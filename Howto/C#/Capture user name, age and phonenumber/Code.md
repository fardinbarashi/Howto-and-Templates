```
// Create a console application that holds
// Persons name, age, phonenumber and if they are alive the applications should say that they are not alive
// Name, age and phonenumber shall be captured by the user input.
```


```


class Program
{
    static void Main()
    {
        // Ask for name
        Console.Write("What is your Name ");
        string name = Console.ReadLine();

        //  Ask mobilenumber
        Console.Write("What is your Phonenumber ");
        string mobileNumber = Console.ReadLine();

        // Ask SSN
        Console.Write("What is your Social Security number, 12 digits ");
        string ssn = Console.ReadLine();
        // Check if SSN is legit
        if (ssn.Length != 12)
        {
            Console.WriteLine("not correct ssn lenght ");
            return;
        }

        // extract SSN
        int yearOfBirth = int.Parse(ssn.Substring(0, 4));
        int yearOfMonth = int.Parse(ssn.Substring(4, 2));
        int yearOfDay = int.Parse(ssn.Substring(6, 2));

        // Count Todays age
        DateTime myAgeDate = new DateTime(yearOfBirth, yearOfMonth, yearOfDay);
        int myAgeToday = DateTime.Now.Year - yearOfBirth;


        // Count age, add 25 years
        int yearIn25Years = myAgeToday + 25;

        // Check if persons is alive today
        bool isAliveToday = myAgeToday <= 100;

        // Write Result
        if (isAliveToday) {
            Console.WriteLine("Hello " + name);
            Console.WriteLine("Your age today is " + myAgeToday);
            Console.WriteLine("YOur age in 25 years will be " + yearIn25Years);
            Console.WriteLine("If you want we can send this info to you on " + mobileNumber);
        }
        else
        {
            Console.WriteLine("Hello " + name);
            Console.WriteLine("You are not alive ");

        }
    }
}



```

