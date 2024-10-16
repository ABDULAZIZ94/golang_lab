package main

import (
	"bytes"
	"fmt"
	"io"
	"log"
	"os"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
	"github.com/aws/aws-sdk-go/service/s3/s3manager"
	"github.com/joho/godotenv"
)

// Here, you can choose the region of your bucket
func main() {
	if err := godotenv.Load(".env"); err != nil {
		log.Print("No .env file found")
	}

	aws_id := os.Getenv("AWS_ID")
	aws_region := os.Getenv("AWS_REGION")
	aws_secret := os.Getenv("AWS_SECRET")

	sess, err := session.NewSession(&aws.Config{
		Credentials: credentials.NewStaticCredentials(
			aws_id,
			aws_secret,
			"", // a token will be created when the session it's used.
		),
		Region: aws.String(aws_region),
	})
	if err != nil {
		fmt.Println("Error creating session:", err)
		return
	}
	svc := s3.New(sess)

	bucket := "smart-toilet/toilet-music/"
	// bucket := "smart-toilet/toilet-music" //forget / at the end
	filePath := "./music1.mp3"

	file, err := os.Open(filePath)
	if err != nil {
		fmt.Fprintln(os.Stderr, "Error opening file:", err)
		return
	}
	defer file.Close()

	key := "music1.mp3"

	// Read the contents of the file into a buffer
	var buf bytes.Buffer
	if _, err := io.Copy(&buf, file); err != nil {
		fmt.Fprintln(os.Stderr, "Error reading file:", err)
		return
	}

	// This uploads the contents of the buffer to S3
	_, err = svc.PutObject(&s3.PutObjectInput{
		Bucket: aws.String(bucket),
		Key:    aws.String(key),
		Body:   bytes.NewReader(buf.Bytes()),
	})
	if err != nil {
		fmt.Println("Error uploading file:", err)
		return
	}

	fmt.Println("File uploaded successfully!!!")

	// // The session the S3 Downloader will use
	// sess, err = session.NewSession(&aws.Config{
	// 	Credentials: credentials.NewStaticCredentials(
	// 		"AKIAUM2TD2VTILTPLCUU",
	// 		"uPzvajoeEDxAUaoHChKZO7subLsPl0J9zn24SFej",
	// 		"", // a token will be created when the session it's used.
	// 	),
	// 	Region: aws.String(region),
	// })

	// Create a downloader with the session and default options
	downloader := s3manager.NewDownloader(sess)

	filename := "dfile.mp3"
	// Create a file to write the S3 Object contents to.
	f, err := os.Create(filename)
	if err != nil {
		fmt.Printf("failed to create file %q, %v", filename, err)
	}

	// Write the contents of S3 Object to the file
	n, err := downloader.Download(f, &s3.GetObjectInput{
		Bucket: aws.String(bucket),
		Key:    aws.String(key),
	})
	if err != nil {
		fmt.Printf("failed to download file, %v", err)
	}
	fmt.Printf("file downloaded, %d bytes\n", n)
}
