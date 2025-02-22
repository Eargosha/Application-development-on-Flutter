# Testt

Новый проект на Flutter

## Как же я его создал

1. Был установлен Flutter на ПК, инструкция использована с официального сайта [Install | Flutter](https://docs.flutter.dev/get-started/install).
2. Установлено расширение Flutter в VS Code.
3. Затем была произведена установка Android Studio, лишь для того, чтобы поставить через нее Android SDK [Download Android Studio & App Tools - Android Developers](https://developer.android.com/studio).
4. После Flutter был добавлен в "Переменные среды" Windows.
5. В командной строке была выполнена команда `flutter doctor`, результат которой показал две ошибки в пунктах: Android SDK был не найден (важная), и Visual Studio также не была найдена (не хочу ее).
6. Выполнив команду `flutter --android-sdk "<путь-к-sdk>"`, дал Flutter доступ к SDK.
7. Повторив команду `flutter doctor`, выяснилось, что в Android SDK не хватает `cmdline-tools`, и некоторые лицензии не были приняты.
8. Установка `cmdline-tools` была произведена в настройке `Manage SDK` от Android Studio.
9. Лицензии приняты командой `flutter doctor --android-licenses`.
10. Снова была выполнена проверочная команда `flutter doctor`, которая показала результат в виде одной ошибки — нехватки Visual Studio. Надо будет — установится.
11. После всех действий был создан проект Flutter "Application" в VS Code (`Shift + Ctrl + P` => `flutter: new project`).
12. После создания проекта был выбран девайс, с которого нужно производить запуск проекта (`Shift + Ctrl + P` => `flutter: select device` => `Medium Phone API 35`). Эмулятор девайса запустился.
13. Затем уже был произведен непосредственно сам запуск проекта (`F5`).
14. Через VS Code был инициализирован Git в папке проекта, создан первый коммит.
15. После создания коммита репозиторий был запушен по [адресу](https://github.com/Eargosha/1-stFlutterLab).