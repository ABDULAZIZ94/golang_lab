# prevent null struct value

	respModel := AnalyticDataRes{
		TrafficCounter: make([]TrafficCounterDataRes, 0),
		Ammonia:        []AmmoniaDataRes{},
	}