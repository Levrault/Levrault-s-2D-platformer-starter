# Levrault's 2D platformer starter

Demo can be downloaded and played there https://levrault.itch.io/levraults-2d-platformer-starter

This is my custom starter project to quickly create a 2D platformer. Feel free to use it to start your own project. Just keep in mind it has been made to suit my way of developing but I think you can maybe find some useful tips.

The project contains

- Navigable menu interface with screen transition. 
- Translatable interface
- Persistent settings menu (video, audio, key binding, language etc.)
- A ready to use Hierarchical state machine based on [GDQuest course](https://gdquest.mavenseed.com/courses) with basic move set (move, jump, run, attack)
- Castlevania navigation style rooms based level. A level is composed of multiples small rooms (scene), they are all loaded in memory and character can navigate through them)
- A branch dialogue system
- Unlockable abilities
- Save/Load system



## Wiki

I try my best to keep the [wiki](https://github.com/Levrault/Levrault-s-2D-platformer-starter/wiki) page up to date, you should find an explanation for almost every module.



## Guidelines

See [GDQuest's best practices guide](https://www.gdquest.com/docs/guidelines/best-practices/) and [official Gdscript Guidelines](https://docs.godotengine.org/en/3.2/getting_started/scripting/gdscript/gdscript_styleguide.html#code-order)

The only main difference, is own I approach the return behavior. I prefer make earlier return (to reduce nesting) instead of keeping only one value to return at the end. This is based on my [goland experience](https://dave.cheney.net/practical-go/presentations/qcon-china.html#_return_early_rather_than_nesting_deeply)



## Folder's Structure

I tried to make my project structure clear as possible. An `assets` folders for every resources (sprites, audio, json files) and a `src` folder to contains the code and game logics.

The only rules insides the `src` folders is that, every kinds of UI, GUI, go inside the `Interfaces` folders and every singletons goes on the `Autoload` folder.

The rest is divided between roles and code design decision.
