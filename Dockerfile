FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS development

RUN apk update \
  && apk --no-cache add curl procps unzip \
  && wget -qO- https://aka.ms/getvsdbgsh | /bin/sh /dev/stdin -v latest -l /vsdbg

RUN addgroup -g 1000 dotnet \
    && adduser -u 1000 -G dotnet -s /bin/sh -D dotnet

USER dotnet
WORKDIR /home/dotnet

COPY --chown=dotnet:dotnet ./PaceCalculator/*.csproj ./PaceCalculator/
RUN dotnet restore ./PaceCalculator/PaceCalculator.csproj
COPY --chown=dotnet:dotnet ./PaceCalculator/ ./PaceCalculator/
RUN dotnet publish ./PaceCalculator/ -c Release -o /home/dotnet/out

FROM nginxinc/nginx-unprivileged:1-alpine AS production

WORKDIR /usr/share/nginx/html
COPY --from=development /home/dotnet/out/wwwroot .

