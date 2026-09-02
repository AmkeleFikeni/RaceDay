CREATE DATABASE RaceDayDB;

GO

/*  USERS*/

CREATE TABLE Users
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,

    FirstName NVARCHAR(50) NOT NULL,

    LastName NVARCHAR(50) NOT NULL,

    Email NVARCHAR(150) NOT NULL UNIQUE,

    PasswordHash NVARCHAR(255) NOT NULL,

    Role NVARCHAR(20) NOT NULL,

    PhoneNumber NVARCHAR(20) NULL,

    CreatedAt DATETIME NOT NULL
        DEFAULT GETDATE(),

    CONSTRAINT CK_Users_Role
        CHECK (Role IN ('Organiser', 'Participant'))
);
GO

/* EVENTS */

CREATE TABLE Events
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,

    OrganiserID INT NOT NULL,

    EventName NVARCHAR(150) NOT NULL,

    EventDate DATE NOT NULL,

    Location NVARCHAR(200) NOT NULL,

    Distance DECIMAL(6,2) NOT NULL,

    EventType NVARCHAR(20) NOT NULL,

    Description NVARCHAR(500) NULL,

    Status NVARCHAR(30) NOT NULL
        DEFAULT 'Open',

    CreatedAt DATETIME NOT NULL
        DEFAULT GETDATE(),

    CONSTRAINT FK_Events_Users
        FOREIGN KEY (OrganiserID)
        REFERENCES Users(UserID),

    CONSTRAINT CK_Events_Distance
        CHECK (Distance > 0),

    CONSTRAINT CK_Events_EventType
        CHECK (EventType IN ('Run', 'Walk', 'Cycle')),

    CONSTRAINT CK_Events_Status
        CHECK (Status IN ('Open', 'Closed', 'Cancelled'))
);
GO

/* CATEGORIES */

CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,

    CategoryName NVARCHAR(100) NOT NULL UNIQUE,

    Description NVARCHAR(300) NULL
);
GO

/* EVENT CATEGORIES */

CREATE TABLE EventCategories
(
    EventCategoryID INT IDENTITY(1,1) PRIMARY KEY,

    EventID INT NOT NULL,

    CategoryID INT NOT NULL,

    EntryFee DECIMAL(10,2) NOT NULL
        DEFAULT 0.00,

    MaximumParticipants INT NOT NULL,

    CONSTRAINT FK_EventCategories_Events
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID),

    CONSTRAINT FK_EventCategories_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID),

    CONSTRAINT CK_EventCategories_EntryFee
        CHECK (EntryFee >= 0),

    CONSTRAINT CK_EventCategories_MaxParticipants
        CHECK (MaximumParticipants > 0),

    CONSTRAINT UQ_Event_Category
        UNIQUE (EventID, CategoryID)
);
GO

/*  ENROLMENTS */

CREATE TABLE Enrolments
(
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,

    ParticipantID INT NOT NULL,

    EventCategoryID INT NOT NULL,

    EnrolmentDate DATETIME NOT NULL
        DEFAULT GETDATE(),

    Status NVARCHAR(30) NOT NULL
        DEFAULT 'Active',

    CONSTRAINT FK_Enrolments_Participants
        FOREIGN KEY (ParticipantID)
        REFERENCES Users(UserID),

    CONSTRAINT FK_Enrolments_EventCategories
        FOREIGN KEY (EventCategoryID)
        REFERENCES EventCategories(EventCategoryID),

    CONSTRAINT CK_Enrolments_Status
        CHECK (Status IN ('Active', 'Cancelled', 'Completed')),

    CONSTRAINT UQ_Participant_EventCategory
        UNIQUE (ParticipantID, EventCategoryID)
);
GO

/*  RESULTS */

CREATE TABLE Results
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,

    EnrolmentID INT NOT NULL UNIQUE,

    FinishTime TIME NULL,

    Position INT NULL,

    ResultStatus NVARCHAR(30) NOT NULL
        DEFAULT 'Finished',

    RecordedAt DATETIME NOT NULL
        DEFAULT GETDATE(),

    CONSTRAINT FK_Results_Enrolments
        FOREIGN KEY (EnrolmentID)
        REFERENCES Enrolments(EnrolmentID),

    CONSTRAINT CK_Results_Position
        CHECK (Position IS NULL OR Position > 0),

    CONSTRAINT CK_Results_Status
        CHECK
        (
            ResultStatus IN
            ('Finished', 'DNF', 'DNS', 'Disqualified')
        )
);
GO

/*SAMPLE DATA */



INSERT INTO Users
(
    FirstName,
    LastName,
    Email,
    PasswordHash,
    Role,
    PhoneNumber
)
VALUES
(
    'Thabo',
    'Mokoena',
    'thabo@raceday.co.za',
    'HASHED_PASSWORD_001',
    'Organiser',
    '0711111111'
),
(
    'Lerato',
    'Dlamini',
    'lerato@raceday.co.za',
    'HASHED_PASSWORD_002',
    'Organiser',
    '0722222222'
),
(
    'Sipho',
    'Ndlovu',
    'sipho@raceday.co.za',
    'HASHED_PASSWORD_003',
    'Participant',
    '0733333333'
),
(
    'Ayanda',
    'Khumalo',
    'ayanda@raceday.co.za',
    'HASHED_PASSWORD_004',
    'Participant',
    '0744444444'
);
GO

/* EVENTS */

INSERT INTO Events
(
    OrganiserID,
    EventName,
    EventDate,
    Location,
    Distance,
    EventType,
    Description,
    Status
)
VALUES
(
    1,
    'Johannesburg City Run',
    '2026-10-10',
    'Johannesburg',
    10.00,
    'Run',
    'A 10 kilometre city road race.',
    'Open'
),
(
    1,
    'Durban Beach Walk',
    '2026-11-07',
    'Durban',
    5.00,
    'Walk',
    'A recreational five kilometre beach walk.',
    'Open'
),
(
    2,
    'Cape Town Cycle Challenge',
    '2026-12-05',
    'Cape Town',
    21.00,
    'Cycle',
    'A competitive 21 kilometre cycling event.',
    'Open'
);
GO

/* CATEGORIES */

INSERT INTO Categories
(
    CategoryName,
    Description
)
VALUES
(
    'Under 20',
    'Participants younger than 20 years.'
),
(
    'Senior',
    'Adult senior participant category.'
),
(
    '10km',
    'Participants entering the 10 kilometre distance.'
),
(
    '5km',
    'Participants entering the 5 kilometre distance.'
),
(
    '21km',
    'Participants entering the 21 kilometre distance.'
);
GO

/* EVENT CATEGORIES */

INSERT INTO EventCategories
(
    EventID,
    CategoryID,
    EntryFee,
    MaximumParticipants
)
VALUES
(
    1,
    1,
    100.00,
    100
),
(
    1,
    2,
    150.00,
    200
),
(
    1,
    3,
    120.00,
    150
),
(
    2,
    1,
    50.00,
    100
),
(
    2,
    2,
    75.00,
    150
),
(
    2,
    4,
    60.00,
    120
),
(
    3,
    1,
    200.00,
    100
),
(
    3,
    2,
    250.00,
    200
),
(
    3,
    5,
    220.00,
    150
);
GO

/* ENROLMENTS */

INSERT INTO Enrolments
(
    ParticipantID,
    EventCategoryID,
    Status
)
VALUES
(
    3,
    1,
    'Active'
),
(
    3,
    5,
    'Active'
),
(
    4,
    2,
    'Active'
),
(
    4,
    6,
    'Active'
);
GO

/* RESULTS */

INSERT INTO Results
(
    EnrolmentID,
    FinishTime,
    Position,
    ResultStatus
)
VALUES
(
    1,
    '00:52:34',
    15,
    'Finished'
),
(
    3,
    '01:05:21',
    22,
    'Finished'
);
GO

/* VERIFICATION QUERIES */

SELECT * FROM Users;

SELECT * FROM Events;

SELECT * FROM Categories;

SELECT * FROM EventCategories;

SELECT * FROM Enrolments;

SELECT * FROM Results;
GO