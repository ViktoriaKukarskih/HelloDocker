# Используем официальный образ .NET SDK для сборки
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Копируем проект и восстанавливаем зависимости
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Используем официальный runtime образ
FROM mcr.microsoft.com/dotnet/runtime:6.0
WORKDIR /app
COPY --from=build /app/out .

# Указываем команду запуска приложения
ENTRYPOINT ["dotnet", "HelloDocker.dll"]
