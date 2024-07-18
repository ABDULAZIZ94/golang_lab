package gate

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/bitly/go-simplejson"

	"github.com/dgrijalva/jwt-go"
)

type contextKey struct {
	name string
}

var (
	TokenCtxKey = &contextKey{"Token"}
	ErrorCtxKey = &contextKey{"Error"}
)

type (
	JWTStruct struct {
		SignKey    interface{}
		verifyKey  interface{}
		SignMethod jwt.SigningMethod
		parser     *jwt.Parser
	}

	MergeClaims struct {
		UserID           string
		TenantID         string
		Email            string
		UserType         string
		AccessLevel      string
		BranchStateID    int
		BranchDistrictID int
		AllAccess        bool
		// ContractorID     string
		jwt.StandardClaims
	}
)

func NewAuth() *JWTStruct {
	key, _ := os.LookupEnv("SCRT_KEY")

	return &JWTStruct{
		SignKey:    []byte(key),
		SignMethod: jwt.GetSigningMethod("HS256"),
		parser:     &jwt.Parser{},
	}
}

func (a *JWTStruct) AuthMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := r.Context()
		header := GetTokenFromHeader(r)
		validate, err := a.ValidateKey(header)
		if err != nil {
			log.Println(err)

			http.Error(w, http.StatusText(401), 401)
		} else {
			ctx = NewContext(ctx, validate, err)
			if validate == nil || !validate.Valid {
				http.Error(w, http.StatusText(401), 401)
			}

			next.ServeHTTP(w, r.WithContext(ctx))
		}

	})
}
func (a *JWTStruct) ValidateKey(tokenn string) (*jwt.Token, error) {

	if tokenn == "" {
		return nil, errors.New("Token not found")
	}

	// Verify the token
	token, err := a.Decode(tokenn)

	if err != nil {

		verr := err.(*jwt.ValidationError)

		if verr != nil {
			if verr.Errors&jwt.ValidationErrorExpired > 0 {
				errors.New("Token expired")
			} else if verr.Errors&jwt.ValidationErrorIssuedAt > 0 {
				errors.New("xtau sapa bagi nih")
			} else if verr.Errors&jwt.ValidationErrorIssuer > 0 {
				errors.New("xtau sapa bagi nih")
			}
		}

		return token, err
	}

	if token == nil || !token.Valid {
		err = errors.New("Token not valid")

		return token, err
	}

	// Verify signing algorithm
	if token.Method != a.SignMethod {
		return token, errors.New("Sing method not calid")
	}

	// Valid!
	return token, nil

}
func (a *JWTStruct) Decode(tokenString string) (t *jwt.Token, err error) {

	t, err = a.parser.Parse(tokenString, a.keyFunc)
	if err != nil {
		return nil, err
	}
	return t, nil
}

func (a *JWTStruct) keyFunc(t *jwt.Token) (interface{}, error) {
	return a.SignKey, nil
}

// func JWTMW() func(http.Handler) http.Handler {
// 	return func(next http.Handler) http.Handler {

// 		return Verifier(GetTokenFromHeader, GetTokenFromCookie)(next)
// 	}
// }

// func Verifier(findToken ...func(r *http.Request) string) func(http.Handler) http.Handler {
// 	return func(next http.Handler) http.Handler {

// 		fnc := func(w http.ResponseWriter, r *http.Request) {

// 			next.ServeHTTP(w, r)
// 		}
// 		return http.HandlerFunc(fnc)
// 	}
// }

func GetTokenFromHeader(r *http.Request) string {

	bearer := r.Header.Get("Authorization")
	if len(bearer) > 7 && strings.ToUpper(bearer[0:6]) == "BEARER" {
		return bearer[7:]
	}
	return ""
}

func GetTokenFromCookie(r *http.Request) string {
	cookie, err := r.Cookie("jwt")
	if err != nil {
		return ""
	}
	return cookie.Value

}

// generate new jwt
func GenNewToken(userId, tenantID, email, userType, accessLevel, contractorID string, stateID, districtID int, allaccess bool) (string, error) {

	standard := jwt.StandardClaims{
		ExpiresAt: time.Now().Add(time.Hour * 72).Unix(),
		Issuer:    "Vectolabs-end",
		IssuedAt:  time.Now().Unix(),
	}

	// log.Println(list)

	merge := &MergeClaims{
		userId,
		tenantID,
		email,
		userType,
		accessLevel,
		stateID,
		districtID,
		allaccess,
		// contractorID,
		standard,
	}

	ji := jwt.NewWithClaims(jwt.SigningMethodHS256, merge)
	key, _ := os.LookupEnv("SCRT_KEY")
	log.Println(key)
	tokenstring, err := ji.SignedString([]byte(key))

	if err != nil {
		return "", err
	}

	// fmt.Println("GENERATED KEY: ", tokenstring)
	return tokenstring, nil

}

func NewContext(ctx context.Context, t *jwt.Token, err error) context.Context {
	// ctx, _ := context.WithCancel(context.Background())
	ctx = context.WithValue(ctx, TokenCtxKey, t)
	ctx = context.WithValue(ctx, ErrorCtxKey, err)
	// fmt.Println(Get(ctx))
	// fmt.Println(ctx.Value(1))
	return ctx
}

func Get(ctx context.Context) (*simplejson.Json, error) {
	token, _ := ctx.Value(TokenCtxKey).(*jwt.Token)
	fmt.Printf("jwtauth: token of the Claims: %v, context: %v\n", token, ctx)

	var claims jwt.MapClaims
	if token != nil {
		if tokenClaims, ok := token.Claims.(jwt.MapClaims); ok {
			claims = tokenClaims
		} else {
			panic(fmt.Sprintf("jwtauth: unknown type of Claims: %T\n", token.Claims))
		}
	} else {
		claims = jwt.MapClaims{}
	}

	err, _ := ctx.Value(ErrorCtxKey).(error)

	b, err := json.Marshal(claims)
	if err != nil {
		fmt.Println("error:", err)
	}
	data, err := simplejson.NewJson(b)
	if err != nil {
		return nil, err
	}

	fmt.Printf("jwtauth.Get data: %v claims:%v\n", data, b)
	return data, err
}
