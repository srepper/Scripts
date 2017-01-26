<Query Kind="Program" />

// Test if n can be represented as the sum of k prime numbers
void Main(int n, int k)
{
	PrimeSum(9, 4).Dump();
	PrimeSum(9, 5).Dump();
	PrimeSum(7, 1).Dump();
	PrimeSum(7, 4).Dump();
	PrimeSum(50, 3).Dump();
}

// Define other methods and classes here
bool PrimeSum(int n, int k)
{
	var primes = new[] { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101 };
	
	var testSet = primes.Select(x => new[] { x }.ToList());
	
	for (int i = 0; i < (k-1); i++)
	{
		testSet = AddToTestSet(testSet, primes);
	}
	
	return testSet.Any(x => x.Sum() == n);
}

IEnumerable<List<int>> AddToTestSet(IEnumerable<List<int>> input, int[] primes)
{
	return input.SelectMany(x => 
		primes.Select(y => 
			x.Concat(new[] { y })
				.ToList()
		)
	);
}