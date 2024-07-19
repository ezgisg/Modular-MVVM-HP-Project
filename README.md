# Harry Potter Characters App
This project demonstrates a **modular structure** by fetching information about characters from the Harry Potter series using the hp-api. The project includes basic two main screens and is designed following the **MVVM** architecture with UIKit.

![flow-hp](https://github.com/user-attachments/assets/4a54b035-074e-4f1e-9d98-05c370cf7275)

## Features
* **Modular Architecture:** The project is designed with a modular structure, ensuring that each component is self-contained and can be easily maintained or extended.
* **MVVM Architecture:** The project is structured following the Model-View-ViewModel (MVVM) pattern to ensure a clear separation of concerns.
* **Compositional Layout & Diffable Data Source:** These modern collection view features are used to create a responsive and efficient user interface.
* **Search Functionality:** The home screen includes a search feature that performs a local search through all displayed information. If no results are found, an empty view is shown.
* **Keyboard Dismissal:** The keyboard can be dismissed by tapping anywhere outside the keyboard area.
* **Auto Layout:** The UI is built with Auto Layout to support different screen sizes. The cells in the UICollectionView resize according to the content, and the details page uses a UIScrollView to display detailed information dynamically.

* ###### **iPhone 15**
   <img src="https://github.com/user-attachments/assets/91c3a480-5554-4121-a88f-ce795a9c0187" alt="iphone 15" width="400"/>

* ###### **iPhone SE**
  <img src="https://github.com/user-attachments/assets/7c6bda36-a6b6-4f67-9015-d28dbd4de123" alt="iphone SE" width="255"/>

  
## Screens
**Home Screen:**
* Displays a list of Harry Potter characters.
* Provides a search bar for filtering characters by name or other attributes.
* Shows an empty view if no search results are found.

**Detail Screen:**
* Displays detailed information about a selected character.
* The layout adapts to the amount of content, ensuring a smooth and user-friendly experience.

## File Structure
<img width="362" alt="Ekran Resmi 2024-07-19 20 34 40" src="https://github.com/user-attachments/assets/751416ee-1c98-41c8-a453-634f76c37337">

## Sample Video
https://github.com/user-attachments/assets/794a8525-e9d9-4815-a600-759f292bf93a
