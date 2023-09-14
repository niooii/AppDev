import "dart:io";

//this semes like an incredimly impractical way of solving this problem but it is part of the requirements
enum Period
{
  One,
  Two,
  Three,
  Four,
  Five,
  Six,
  Seven,
  Eight,
  Nine,
  InBetween,
}

/*
Period 1 - 8:05 am - 8:46 am
485 - 526
Period 2 - 8:51 am - 9:32 am
531 - 572
Period 3 - 9:37 am - 10:20 am
577 - 618
Period 4 - 10:25 am - 11:06 am
623 - 664
Period 5 - 11:11 am - 11:52 am
669 - 710
Period 6 - 11:57 am - 12:38 pm
715 - 756
Period 7 - 12:43 pm - 1:24 pm
761 - 802
Period 8 - 1:29 pm - 2:10 pm
807 - 848
Period 9/SGI - 2:15 pm - 2:56 pm (SGI until 2:52 pm)
SGI - 3:01 pm to 3:38 pm
*/

void main()
{
  String enteredTime = stdin.readLineSync().toString();

  int hour = int.parse(enteredTime.substring(0, enteredTime.indexOf(':')));
  int minute = int.parse(enteredTime.substring(enteredTime.indexOf(':')+1, enteredTime.indexOf(' ')));
  String ampm = enteredTime.substring(enteredTime.indexOf(' ') + 1, enteredTime.length);

  // print("hour: $hour\nminute: $minute\nam or pm: $ampm");
  Period current = GetPeriod(hour, minute, ampm);
  
  switch(current)
  {
    case Period.One:
        print("period 1");
        break;

    case Period.Two:
        print("period 2");
        break;

    case Period.Three:
        print("period 3");
        break;

    case Period.Four:
        print("period 4");
        break;

    case Period.Five:
        print("period 5");
        break;

    case Period.Six:
        print("period 6");
        break;

    case Period.Seven:
        print("period 7");
        break;

    case Period.Eight:
        print("period 8");
        break;

    case Period.Nine:
        print("period 9");
        break;

      case Period.InBetween:
        print("inbetween periods");
      break;

  }
}

Period GetPeriod(int hour, int minute, String ampm)
{
  int minutesElapsed = (ampm == "pm" ? hour * 60 + (12*60) + minute : hour * 60 + minute);

  if(minutesElapsed >= 485 && minutesElapsed <= 526) return Period.One;
  else if(minutesElapsed >= 531 && minutesElapsed <= 572) return Period.Two;
  else if(minutesElapsed >= 577 && minutesElapsed <= 618) return Period.Three;
  else if(minutesElapsed >= 623 && minutesElapsed <= 664) return Period.Four;
  else if(minutesElapsed >= 669 && minutesElapsed <= 710) return Period.Five;
  else if(minutesElapsed >= 715 && minutesElapsed <= 756) return Period.Six;
  else if(minutesElapsed >= 761 && minutesElapsed <= 802) return Period.Seven;
  else if(minutesElapsed >= 807 && minutesElapsed <= 848) return Period.Eight;
  else if(minutesElapsed >= 853 && minutesElapsed <= 894) return Period.Nine;
  else return Period.InBetween;
}