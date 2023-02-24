package main

import (
	"math"
	"math/rand"

	"scientificgo.org/special"
)

type TimeStepNumber int

type StateElement float64
type StateVector []StateElement
type StateHistory []StateVector

// both below are in some unit, e.g., seconds
type TimeIncrement float64
type TotalElapsedTime float64

type HurstExponent float64

type SmallTimeInterval float64

// get the next increment from this step number forward
func TimeIncrementFunction(
	timeStepNumber TimeStepNumber,
) TimeIncrement {
    // compute the next increment
	return nextTimeIncrement
}

// get the next increment from this step number forward
func ExpDistributedTimeIncrementFunction(
	smallTimeInterval SmallTimeInterval,
) TimeIncrement {
    nextTimeIncrement := float64(smallTimeInterval) * rand.ExpFloat64()
	return TimeIncrement(nextTimeIncrement)
}

// compute the total time elapsed up to the input step number
func TotalTimeElapsedFunction(timeStepNumber TimeStepNumber) TotalElapsedTime {
	totalElapsedTime := 0.0
	for t := 0; t < timeStepNumber; t++ {
		totalElapsedTime += TimeIncrementFunction(t)
	}
	return totalElapsedTime
}

// some function
func G(wienerProcessSample float64, timeStepNumber TimeStepNumber) float64 {
	// return something
}

// discretely represents the dg/dt expression in the equation above
func DgDt(
	newWienerProcessSample float64,
	previousWienerProcessSample float64,
	timeStepNumber TimeStepNumber,
) float64 {
	return (G(newWienerProcessSample, timeStepNumber) -
		G(previousWienerProcessSample, timeStepNumber)) /
		float64(TimeIncrementFunction(timeStepNumber))
}

// discretely represents the dg/dx expression in the equation above
func DgDx(
	newWienerProcessSample float64,
	previousWienerProcessSample float64,
	timeStepNumber TimeStepNumber,
) float64 {
	return (G(newWienerProcessSample, timeStepNumber) -
		G(previousWienerProcessSample, timeStepNumber)) /
		(newWienerProcessSample - previousWienerProcessSample)
}

// discretely represents the d^2g/dx^2 expression in the equation above
func D2gDx2(
	// newDgDx and previousDgDx could be passed in here
	newWienerProcessSample float64,
	previousWienerProcessSample float64,
	timeStepNumber TimeStepNumber,
) float64 {
	// newDgDx and previousDgDx are the result of applying the function
	// for dg/dx defined above on two different timesteps
	return (newDgDx - previousDgDx) /
		(newWienerProcessSample - previousWienerProcessSample)
}

// generate a new Wiener process increment for a state element
func NewWienerProcessIncrement(timeStepNumber TimeStepNumber) StateElement {
	// use the time increment function we defined earlier
	timeIncrement := TimeIncrementFunction(timeStepNumber)
	// multiply by the square-root here as
	// it is proportional to the standard deviation
	value := math.Sqrt(timeIncrement) * rand.NormFloat64()
	return StateElement(value)
}

// computes the integral term in the fractional Brownian motion process
// defined above using come scientific libraries
func ComputeTheIntegral(
	currentTime TotalElapsedTime,
	nextTime TotalElapsedTime,
	hurstExponent HurstExponent,
	numberOfIntegrationSteps int,
) float64 {
	currentT := float64(currentTime)
	nextT := float64(nextTime)
	integralStepSize := nextT - currentT/float64(numberOfIntegrationSteps)
	h := float64(hurstExponent)
	a := []float64{h - 0.5, 0.5 - h}
	b := []float64{h + 0.5}
	integralValue := 0.0
	// implements the trapezium rule in a loop over the steps
	// between the current and the next point in time
	for t := 0; t < numberOfIntegrationSteps; t++ {
		t1 := currentT + float64(t)*integralStepSize
		t2 := t1 + integralStepSize
		functionValue1 := (math.Pow(t1-currentT, h-0.5) / math.Gamma(h+0.5)) *
			special.HypPFQ(a, b, 1.0-t1/currentT)
		functionValue2 := (math.Pow(t2-currentT, h-0.5) / math.Gamma(h+0.5)) *
			special.HypPFQ(a, b, 1.0-t2/currentT)
		integralValue += 0.5 * (functionValue1 + functionValue2) * integralStepSize
	}
	return integralValue
}

// returns the time-inhomogeneous Poisson process S(X',t) term 
func SFunctionInhomogeneousPoissonProcess(
	stateHistory StateHistory,
	timeStepNumber TimeStepNumber,
) StateVector {
    var smallTimeInterval SmallTimeInterval

	// notice how the noise is also Markovian here too
	sFunctionValue := make(StateVector, 0)
	for element = range stateVector {
		timeIncrement := ExpDistributedTimeIncrementFunction(smallTimeInterval)
		// specify an arbitrary function of time for the event rate here
		eventRateLambda := EventRateLambdaFunction(timeStepNumber)
		element := StateElement(0.0)
		prob := eventRateLambda / 
		    (eventRateLambda + 1.0/float64(timeIncrement))
		if rand.Float64() < prob {
		    element = StateElement(1.0)
		}
		sFunctionValue = append(sFunctionValue, element)
	}
	return sFunctionValue
}

// returns the state vector from the S(X',t) function we defined
// in the main text above
func SFunctionWienerProcess(
	stateHistory StateHistory,
	timeStepNumber TimeStepNumber,
) StateVector {
	stateVector := stateHistory[0]
	sFunctionValue := make(StateVector, 0)
	// being really clear here instead of doing this the obviously faster way
	currentTime := TotalTimeElapsedFunction(timeStepNumber)
	nextTime := TotalTimeElapsedFunction(timeStepNumber + 1)
	timeIncrement := TimeIncrementFunction(timeStepNumber)
	// note that we don't care about the history in this case = Markovian
	for _ = range stateVector {
		increment := NewWienerProcessIncrement(timeStepNumber)
		factorInFrontOfIntegral := float64(increment) / float64(timeIncrement)
		integralValue := ComputeTheIntegral(currentTime, nextTime, ... , ...)
		sFunctionValue = append(sFunctionValue, StateElement(factorInFrontOfIntegral*integralValue))
	}
	return sFunctionValue
}

