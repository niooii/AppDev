  enum AudioState
  {
    PLAYING,
    PAUSED,
    STOPPED,
  }

  void main()
  {
    AudioState audioState = AudioState.PLAYING;
    
    switch(audioState)
    {
      case AudioState.PLAYING:
        print("audio is playing");
      break;

      case AudioState.PAUSED:
        print("audio is paused");
      break;

      case AudioState.STOPPED:
        print("audio stopped");
      break;
    }

  }