# 1. Встановлюємо SDK для збірки
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Копіюємо все і збираємо
COPY . ./
RUN dotnet publish -c Release -o out

# 2. Використовуємо runtime-образ
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Запускаємо застосунок
ENTRYPOINT ["dotnet", "StudentInfoSite.dll"]
