# Diarization-Splitter
Splits a produced .srt file into multiple, separate tracks and maintains timing, per speaker.
It is extremely useful for editing in davinci resolve where each subtitle track can have
mutliple regions, which can be color coded or otherwise enhanced for clarity.

This project was designed for https://github.com/MahmoudAshraf97/whisper-diarization
and the files it produces, that is an .srt file with each individual speaker
being denoted by "Speaker X:" in the file.

# How to use
> [!IMPORTANT]
> Place split.ps1 in a convenient location, likely inside of the whisper diarization folder.
> Use the following command to split the srt file:
> `.\split.ps1 -InputFile .\audio.srt`


### Here's an example of the end message when it runs successfully:
```
Speakers found: Speaker_0
Created file: Speaker_0.srt with 377 blocks
Splitting complete. The following files were created:
- Speaker_0.srt
```
Each file is named after it's respective speaker for ease of use and simplicity.
Any potential errors should be quite clear and easily resolvable.
