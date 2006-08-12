@echo off

ikvmc -assembly:Saxon.NET -keyfile:Saxon.NET-StrongNameKeyPair.sn -target:library -version:0.2.8.3 -noglobbing -opt:fields Saxon.NET.jar

ikvmc -assembly:Transform -keyfile:Saxon.NET-StrongNameKeyPair.sn -reference:Saxon.NET.dll -target:exe -version:0.2.8.3 -noglobbing -opt:fields DoTransform.class

ikvmc -assembly:Query -keyfile:Saxon.NET-StrongNameKeyPair.sn -reference:Saxon.NET.dll -target:exe -version:0.2.8.3 -noglobbing -opt:fields DoQuery.class

ikvmc -assembly:Compile -keyfile:Saxon.NET-StrongNameKeyPair.sn -reference:Saxon.NET.dll -target:exe -version:0.2.8.3 -noglobbing -opt:fields DoCompile.class

pause

