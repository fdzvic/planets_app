# Planets App

## Descripción

Planets App es una aplicación desarrollada en Flutter que permite explorar información sobre los planetas del sistema solar. La aplicación sigue principios de arquitectura limpia, lo que facilita su mantenimiento y escalabilidad.

## Tecnologías Utilizadas

- **Flutter**: 3.22.3
- **Dart**: 3.4.4

## Estructura del Proyecto

La estructura del proyecto está organizada de la siguiente manera:

- `lib/`
  - `core/`
    - `data/`: Aquí se manejan los datos de la aplicación.
    - `domain/`: Contiene la lógica de negocio.
    - `presentation/`: Incluye las herramientas y widgets globales de la aplicación organizados bajo la metodologia atomic design.
  - `features/`: Contiene las funcionalidades específicas de la aplicación.

## Despliegue

La aplicación está desplegada en Firebase Hosting y se puede acceder a través de la siguiente URL:

[Planets App](https://planets-app-d0b3c.web.app/#/home)

## Repositorio

El código fuente de la aplicación está disponible en GitHub:

[Repositorio de Planets App](https://github.com/fdzvic/planets_app)

## Instalación y Ejecución

Para ejecutar la aplicación en vs-code, sigue estos pasos:

1. Asegúrate de tener Flutter y Dart instalados en tu máquina.
2. Abre el terminal y navega hasta el directorio del proyecto.
3. Ejecuta los siguientes comandos:

   ```bash
   flutter clean
   flutter pub get
   flutter run -d chrome --web-renderer html

Nota: Es necesario usar el flag --web-renderer html para evitar problemas de CORS con el servidor y asegurarte de que las imágenes se muestren correctamente.
