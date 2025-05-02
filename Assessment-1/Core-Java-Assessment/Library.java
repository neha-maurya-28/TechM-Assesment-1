class Book {
    String title;
    String author;
    double price;

    // Constructor
    public Book(String title, String author, double price) {
        this.title = title;
        this.author = author;
        this.price = price;
    }
    
    public void displayBook() {
        System.out.println("Title: " + title);
        System.out.println("Author: " + author);
        System.out.println("Price: $" + price);
        System.out.println("---------------------------");
    }
}

public class Library {
    public static void main(String[] args) {
        // Creating an array of Book objects
        Book[] books = new Book[5];

        // Initializing books
        books[0] = new Book("The Alchemist", "Paulo Coelho", 9.99);
        books[1] = new Book("1984", "George Orwell", 14.99);
        books[2] = new Book("To Kill a Mockingbird", "Harper Lee", 12.99);
        books[3] = new Book("The Great Gatsby", "F. Scott Fitzgerald", 10.99);
        books[4] = new Book("Moby Dick", "Herman Melville", 15.99);

        String searchTitle = "1984"; 
        searchBook(books, searchTitle);
    }

    public static void searchBook(Book[] books, String title) {
        for (Book book : books) {
            if (book.title.equalsIgnoreCase(title)) {
                System.out.println("Book found!");
                book.displayBook();
                return;
            }
        }
        System.out.println("Book not found.");
    }
}