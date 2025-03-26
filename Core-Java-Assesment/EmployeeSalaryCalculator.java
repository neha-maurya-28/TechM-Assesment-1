import java.util.Scanner;

class Employee {
    // Private attributes (Encapsulation)
    private String name;
    private int id;
    private double basicSalary;
    
    // Constructor to initialize Employee details
    public Employee(String name, int id, double basicSalary) {
        this.name = name;
        this.id = id;
        this.basicSalary = basicSalary;
    }
    
    // Method to calculate net salary
    public double calculateNetSalary() {
        double bonus = 0.10 * basicSalary;  // 10% bonus
        double tax = 0.05 * basicSalary;    // 5% tax deduction
        return basicSalary + bonus - tax;
    }
    
    // Method to display employee salary details
    public void displaySalaryDetails() {
        System.out.println("\nEmployee Salary Details:");
        System.out.println("Name: " + name);
        System.out.println("ID: " + id);
        System.out.println("Basic Salary: $" + basicSalary);
        System.out.println("Net Salary (after bonus & tax): $" + calculateNetSalary());
    }
}

public class EmployeeSalaryCalculator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Taking input from the user
        System.out.print("Enter Employee Name: ");
        String name = scanner.nextLine();

        System.out.print("Enter Employee ID: ");
        int id = scanner.nextInt();

        System.out.print("Enter Basic Salary: ");
        double basicSalary = scanner.nextDouble();

        // Creating an Employee object
        Employee emp = new Employee(name, id, basicSalary);

        // Displaying salary details
        emp.displaySalaryDetails();

        scanner.close();
    }
}