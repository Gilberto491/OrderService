# Etapa de construção
FROM openjdk:17-slim AS build
WORKDIR /build

# Instalar Maven
RUN apt-get update && apt-get install -y maven

# Copiar o código-fonte para o contêiner
COPY . .

# Construir a aplicação
RUN mvn clean package -DskipTests

# Etapa de execução
FROM openjdk:17-slim
WORKDIR /app

# Copiar o arquivo JAR da etapa de construção
COPY --from=build /build/target/OrderService-0.0.1-SNAPSHOT.jar app.jar

# Expôr a porta que a aplicação irá rodar
EXPOSE 8081

# Comando para rodar a aplicação
CMD ["java", "-jar", "app.jar"]