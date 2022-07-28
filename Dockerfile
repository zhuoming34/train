FROM mcr.microsoft.com/dotnet/core/sdk:3.1

LABEL "com.github.actions.name"="Auto Release Milestone"
LABEL "com.github.actions.description"="Drafts a release base"

LABEL version="0.1.0"
LABEL repository="https://github.com/escampidoglio/auto-release-milestone"
LABEL maintainer="zm"

RUN apt-get update && apt-get install -y jq
RUN dotnet tool install -g GitReleaseManager.Tool

ENV PATH /root/.dotnet/tools:$PATH

COPY entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
