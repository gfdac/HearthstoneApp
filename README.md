# HearthstoneApp

**HearthstoneApp** is an iOS application developed in Swift that allows users to explore and view cards from the game Hearthstone. The application offers features such as displaying card details, searching by name, filtering by different categories, and more.

##  Screen Shots
![Image](https://user-images.githubusercontent.com/1376829/241590897-629d6611-5102-4de8-9113-0b951d85c07f.png)
![Image](https://user-images.githubusercontent.com/1376829/241590899-6e0751e9-2e47-4262-ac84-cf535a218794.png)
![Image](https://user-images.githubusercontent.com/1376829/241590898-825e3f5b-4f41-4c0b-abee-c5ac201ad544.png)
![Image](https://user-images.githubusercontent.com/1376829/241590896-5067d55a-0dd6-4a60-98f0-9d4d4153e904.png)
![Image](https://user-images.githubusercontent.com/1376829/241590895-21c2690e-2cdf-411c-956e-7eedc8d62c60.png)

## Key Features

- **Card View**: Users can view a list of cards with different categories.
- **Card Details**: Users can view the complete details of a card, including its image, text, rarity, statistics (attack, cost, and health), and additional information.
- **Card Search**: Users can search for cards by name, making it easy to locate a specific card.
- **Card Filtering**: The application offers filtering options to help users refine the list of cards based on desired set, type, and faction.
- **Intuitive User Interface**: The user interface is designed to be user-friendly and intuitive, providing a pleasant user experience.

## Folder Structure

The project's file structure follows a modular organization, divided into different folders:

- **CardList**: Contains the files related to the card list, including list view, presentation, interaction, and routing.
- **CardDetail**: Contains the files related to the card details, including detail view, presentation, interaction, and routing.
- **Network**: Contains the files related to the network services used to fetch Hearthstone card data.
- **Extensions**: Contains extensions of classes and structures to add additional functionalities.
- **DesignSystem**: Contains the files related to the application's design system, such as colors, fonts, and sizes.
- **Tests**: Contains the test files for different modules of the application, including unit tests and UI tests.

HearthstoneApp
- CardList
  - CardListViewController.swift
  - CardListPresenter.swift
  - CardListInteractor.swift
  - CardListRouter.swift
  - CardListModels.swift
- CardDetail
  - CardDetailViewController.swift
  - CardDetailPresenter.swift
  - CardDetailInteractor.swift
  - CardDetailRouter.swift
  - CardDetailModels.swift
- Network
  - NetworkService.swift
  - HearthstoneService.swift
- Extensions
  - ...
- DesignSystem
  - ...
- Tests
  - CardListTests
    - CardListViewControllerTests.swift
    - CardListPresenterTests.swift
    - CardListInteractorTests.swift
    - CardListRouterTests.swift
  - CardDetailTests
    - CardDetailViewControllerTests.swift
    - CardDetailPresenterTests.swift
    - CardDetailInteractorTests.swift
    - CardDetailRouterTests.swift
- AppDelegate.swift

## How to Run

To run the application in your development environment, follow the steps below:

1. Make sure you have Xcode installed on your system.
2. Clone this repository to your local machine.
3. Open the `HearthstoneApp.xcodeproj` file in Xcode.
4. Select the target simulator or device.
5. Press the "Run" button or use the `Cmd + R` keyboard shortcut to build and run the application.

## Dependencies

The project has no external dependencies. All necessary classes and libraries are included within the project itself, making the execution simple and straightforward.

## Testing

The application has a comprehensive suite of automated tests to

 ensure code quality and robustness. The tests are organized in the `Tests` folder and include unit tests and UI tests for the `CardList` and `CardDetail` modules.

## Design Principles

The HearthstoneApp project follows the SOLID principles, which are design principles aimed at making software systems more maintainable, scalable, and extensible. Here's a brief overview of how these principles are applied:

- **Single Responsibility Principle (SRP)**: Each class and module in the project has a single responsibility, encapsulating a specific functionality or behavior.
- **Open/Closed Principle (OCP)**: The code is designed to be open for extension but closed for modification, enabling new features to be added through extension rather than modifying existing code.
- **Liskov Substitution Principle (LSP)**: Subtypes are able to replace their base types without affecting the correctness or functionality of the program. This allows for better modularity and flexibility.
- **Interface Segregation Principle (ISP)**: Interfaces are kept small and focused on specific behaviors to avoid bloated interfaces and unnecessary dependencies.
- **Dependency Inversion Principle (DIP)**: High-level modules depend on abstractions, not on concrete implementations, promoting loose coupling and easier maintenance.

## Contribution

Contributions are welcome! If you would like to improve the application, fix bugs, add features, or enhance the documentation, feel free to open issues and submit pull requests. Please follow the project's contribution guidelines.

## License

This project is licensed under the [MIT License](LICENSE), which means you can use it freely in your own projects, commercial or non-commercial.
