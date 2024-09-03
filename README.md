# Diarization-Splitter
Splits a produced .srt file into multiple, separate tracks and maintains timing, per speaker.
It is extremely useful for editing in davinci resolve where each subtitle track can have
mutliple regions, which can be color coded or otherwise enhanced for clarity.

This project was design for https://github.com/MahmoudAshraf97/whisper-diarization
and the files it produces, that is a .srt file with each individual speaker
being denoted by "Speaker X:" in the file.

# How to use
Place split.ps1 in a convenient location, likely inside of the whisper diarization folder.
Use the following command to split it into x separate files, x being the total number of speakers.

`.\split.ps1 -InputFile .\audio.srt`
