class Song
{
  String title, artist;
  Song.fromTitle(this.title) : artist="Unknown Artist"{}
  @override
  String toString()
  {
    return "Song: $title from $artist";
  }
}

int main()
{
  Song s = Song.fromTitle("AWFAF");
  return 0;
}