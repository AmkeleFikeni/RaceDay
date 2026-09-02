
# RaceDay 

## Part 1 – System Planning and Database

## Student Information

| Details | Information |
| **Student Name** | [Enter Your Full Name] |
| **Student Number** | [Enter Student Number] |
| **Module** | [Enter Module Code and Name] |
| **Project Name** | RaceDay Event Management System |
| **Assessment Part** | Part 1 – System Planning and Database |

---

# 1. Project Overview

RaceDay is an event management system designed to support the planning and management of running, walking and cycling events.

The system is designed around two primary user roles: **Organisers** and **Participants**.

Organisers are responsible for managing events, event categories, participant enrolments and race results. Participants can register for the system, maintain their own profile, view available events and categories, enrol in events and view their own results.

Part 1 establishes the technical foundation of the RaceDay system before application development begins. It consists of three main components:

1. **Section A – Entity Relationship Diagram (ERD)**
2. **Section B – API Endpoint Plan**
3. **Section C – SQL Database Script**

The planning documents and SQL script are stored in the `/docs` folder of this GitHub repository.

---

# 2. Part 1 Objectives

The objectives of Part 1 are to:

- Design a relational database for the RaceDay system.
- Identify the entities, attributes and relationships required by the system.
- Clearly define primary keys and foreign keys.
- Define cardinalities between related entities.
- Plan the RESTful API endpoints before implementation.
- Define the HTTP methods, routes, roles, request bodies and expected responses.
- Create the SQL Server database schema.
- Populate the database with realistic sample data.
- Apply database constraints to support data integrity.
- Demonstrate role-based system planning.
- Use GitHub for version control.
- Use GitHub Actions to validate the required repository structure.
- Document the planning process clearly.


## Database

The database contains six entities:

1. Users
2. Events
3. Categories
4. EventCategories
5. Enrolments
6. Results

## API

The API endpoint plan covers:

- Authentication
- User profiles
- Events
- Categories
- Event enrolments
- Results

## CI/CD

GitHub Actions is used to validate that the required Part 1
documentation exists inside the /docs folder.

[INSERT GREEN BUILD SCREENSHOT HERE]

## Demonstration Video

YouTube video:
[INSERT UNLISTED YOUTUBE LINK HERE]
