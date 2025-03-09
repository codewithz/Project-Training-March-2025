CREATE TABLE Staff (
    staff_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(100) CHECK (role IN ('Librarian', 'Assistant')),
    email VARCHAR(255) UNIQUE NOT NULL
);


CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    published_year INT,
    total_stock INT NOT NULL CHECK (total_stock >= 0),  -- Total copies of the book
    available_stock INT NOT NULL CHECK (available_stock >= 0), -- Remaining copies available
    staff_id INT REFERENCES Staff(staff_id) ON DELETE SET NULL, -- Who added the book
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Members (
    member_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    membership_type VARCHAR(50) CHECK (membership_type IN ('Standard', 'Premium')),
    staff_id INT REFERENCES Staff(staff_id) ON DELETE SET NULL, -- Who registered the member
    registered_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Members (
    member_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    membership_type VARCHAR(50) CHECK (membership_type IN ('Standard', 'Premium')),
    staff_id INT REFERENCES Staff(staff_id) ON DELETE SET NULL, -- Who registered the member
    registered_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Loans (
    loan_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES Books(book_id) ON DELETE CASCADE,
    member_id INT REFERENCES Members(member_id) ON DELETE CASCADE,
    staff_id INT REFERENCES Staff(staff_id) ON DELETE SET NULL,
    loan_date DATE DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE,
    fine_amount DECIMAL(10,2) DEFAULT 0,
    status VARCHAR(50) CHECK (status IN ('Borrowed', 'Returned')) DEFAULT 'Borrowed'
);

