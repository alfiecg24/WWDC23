# SecureMe
## My submission for the 2023 Swift Student Challenge

## Selected as a winner! 🎉🎉

SecureMe is a simple app that is designed to teach people about the importance of being cyber-secure. Built in pure SwiftUI, it features a "how secure is my password" calculator, a secure password generator, and some information and statistics about cyber-safety.

Having been a winner of last year's Swift Student Challenge despite submitting a rather simple app, I decided to prioritise a more fluid and intuitive UI this year. I also decided to add a password generator, which can demonstrate how Swift can handle complex mathematics and algorithms. 

The app is fully dark-mode compliant and matches the system's appearance. All measurements are based off of GeometryReader, so it should (just about) work with any window size that fits an iPad or Mac.

I have also demonstrated the use of JSON decoding, alternate fonts, and interesting animations. At the time of writing, the app works quickly and smoothly on my Mac running Swift Playgrounds, and also works just as well on an iPad running Swift Playgrounds too.

## Password brute-force time calculator
For those who are interested, the algorithm for the password generator is as follows:
* Calculate the "pool" of possible characters (e.g. 10 if it contains digits, plus 26 if it contains lowercase letters)
* Calculate the entropy of the password using the formula `log2(pool^length)`
* Calculate the total number of attempts required to crack the password using the formula `2^entropy`
* Divide this by the number of attempts per second (I used 1 billion, which still produced surprisingly large numbers)
* You are now left with the number of seconds required to crack the password with a brute-force attack

## Screenshots
Check out images in the folder `images` for screenshots of the app in action - using both light and dark mode with its clean user interface.
