# BlogMate

BlogMate is a dynamic blog web application designed to provide a user-friendly platform for creating, editing, and sharing blog posts. It features a secure user authentication system, an intuitive post creation interface, and an integrated commenting system that encourages interaction and discussion. The application is backed by a robust database to efficiently manage users, posts, and comments.

## Features

- **User Authentication**
  - Secure login and registration system for users.
  - Password hashing for added security.
  - Session management to keep users logged in.

- **Post Creation**
  - Users can create, edit, and delete blog posts.
  - Rich text editor for enhanced content creation.
  - Supports media uploads (images, videos) for blog posts.

- **Commenting System**
  - Users can comment on blog posts.
  - Real-time comment updates.
  - Edit or delete comments.

- **Database Integration**
  - Robust database for storing user information, posts, and comments.
  - Optimized queries for fast data retrieval and manipulation.

## Tech Stack

- **Frontend:** HTML, CSS, JavaScript, Bootstrap
- **Backend:** Java, JSP, Servlet
- **Database:** MySQL
- **Authentication:** Session-based authentication

## Setup and Installation

To set up the project locally, follow these steps:

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/blogmate.git
    ```

2. Navigate to the project directory:

    ```bash
    cd blogmate
    ```

3. Install required dependencies.

4. Configure your MySQL database:
    - Create a new database.
    - Import the provided SQL file for the initial schema and data.

5. Update database credentials in the configuration file:

    ```java
    // Example: config/database.properties
    db.url=jdbc:mysql://localhost:3306/blogmate_db
    db.username=root
    db.password=yourpassword
    ```

6. Compile and run the project on your local server.

## Usage

1. Open the application in your web browser.
2. Register or log in to access the blog features.
3. Start creating, editing, or deleting posts.
4. Comment on posts to engage with other users.

## Screenshots

### Home Page

<img src="https://github.com/user-attachments/assets/c1f2ba01-fac1-4bc6-9cd1-02c34a066465" alt="Home Page" width="600"/>

### Post Page

<img src="https://github.com/user-attachments/assets/145fae1b-d3d1-4d81-b1aa-134d35e56e46" alt="Post Creation" width="600"/>

### Comment Section

<img src="https://github.com/user-attachments/assets/690217e0-e567-421d-bcfb-599709d3f731" alt="Comment Section" width="600"/>

### Add Post

<img src="https://github.com/user-attachments/assets/0696c19a-2692-4452-a21a-c46bca1b68d3" alt="Edit Post" width="600"/>

### User Profile

<img src="https://github.com/user-attachments/assets/73d3dcff-dbf5-436a-beee-6f18b94c67e7" alt="User Profile" width="600"/>

## Future Enhancements

- Adding categories/tags for blog posts.
- Search functionality for posts.
- Email notifications for comments and post updates.
- User profiles with social links.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request to suggest improvements or report bugs.

## License

This project is licensed under the Apache License.
