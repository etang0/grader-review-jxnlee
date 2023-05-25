CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

#student-submission
# | ListExamples.java

# Then, add here code to compile and run, and do any post-processing of the
# tests
grade=$(( 100 ))
if [[ -f student-submission/ListExamples.java ]] 
then 
    cp TestListExamples.java student-submission/ListExamples.java grading-area
    cp -r lib grading-area
    echo "Submitted correctly"
else  
    echo "Missing ListExamples.java file, submit the correct file"
    grade=$(( $grade - 100 ))
    echo Grade: $grade / 100
    exit
fi

cd grading-area
javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java 2> compileErr.txt
java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > errFile.txt

if [[ $? -eq 0 ]]
then
    echo "No errors: PASS"
else
    echo Compile Errors:
    grep "error" compileErr.txt 
    echo Runtime Errors:
    grep "failure" errFile.txt
    grade=$(( $grade - 50 ))
fi
echo Grade: $grade / 100





