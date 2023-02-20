# Bot Script

#### **Install dependencies**

```sh
  bundle install
```

### **Make start file executable**
```sh
  chmod +x start.sh
```

### **Bot schedule waiting time**
Currently the bot runs after every 5 minutes. Check the file called `schedule.rb` inside the cofig folder. You can change the value *5* to any number between 1 and 59. if you want an hours or days. Use this syntax

```ruby
  1.minute
  5.minutes
  3.hours
  4.days
  2.months

```

### **How to start the script**
```sh
  ./start.sh
```

### **How to stop the script**
```sh
  ./stop.sh
```

## **Audio Files**

They are from [pixabay.com](https://pixabay.com/sound-effects/search/wav/)

I have downloaded only 3 of them. The audio plays for only 5 seconds ie 5000ms

## **Login Credentials**
Use the example in [example.env](./example.env) and create a .env file with login details.


## **Issues with Crontab on Mac**
If you are on mac os, check this article

[Fixing Cron jobs in Mojave](https://www.bejarano.io/fixing-cron-jobs-in-mojave/)

## **How to confirm the job has been added to Cronjob**

Run the following command
```sh
  crontab -l
```