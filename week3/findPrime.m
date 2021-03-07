clear
clc
% N changes from 2 to 30
N = 2:30;

%% using 'rem' : Eratosthenes sieve algorithm
% initialize the (length(N) x 2) matrix 'primeNumbers'
% and assume all N as a prime at first (set true)
tic
primeNumbers = N';
primeNumbers(:, 2) = true;

% (1) if N has a prime as divisor, rem(N,prime) = 0
% (2) every prime has 1 and itself as divisors
% from (1) and (2), prime is the first N satisfying "rem(N, prime)==0"
% the others is not prime (set false)

% for all n < N, Nxn has already checked 
% therefore Ns that satisfy "NxN < N(end)" are enough
for idx = find(N.^2 < N(end))
    if primeNumbers(idx, 2)
        multiplesOfNidx = find(rem(N, N(idx))==0);
        primeNumbers(multiplesOfNidx(2:end), 2) = false;
    end
end
display_res(primeNumbers);
toc

%% using 'isprime'
% initialize the (length(N) x 2) matrix 'primeNumbers'
% and use 'isprime' to check whether N is prime
clear primeNumbers
tic
primeNumbers = N';
primeNumbers(:, 2) = isprime(N);
display_res(primeNumbers);
toc

%% display_res function
% read a matrix row by row and display the result 
function display_res(primeNumbers)
    for iRow = 1:size(primeNumbers, 1)
        if primeNumbers(iRow, 2)
            disp(int2str(primeNumbers(iRow, 1)) + " is prime");
        else
            disp(int2str(primeNumbers(iRow, 1)) + " is not prime");
        end
    end
    disp(primeNumbers); % show a matrix
end