# README

## Overview

This service is designed to facilitate the scheduling of coaching sessions, addressing a core need in the coaching industry for efficient and conflict-free session management. It allows coaches and their clients to book sessions seamlessly, ensuring that there are no overlaps in the coach's schedule.

## Features

1. _Session Scheduling_: Clients can schedule sessions with coaches, specifying the coach, client, start time, and duration of the session.
2. _Conflict Avoidance_: The service automatically checks for any scheduling conflicts. If a proposed session time overlaps with an existing session for the same coach, it will not be booked.
3. _Robust Validation_: All session requests are validated for completeness and integrity of information, ensuring that all necessary data is provided and formatted correctly.
4. _HTTP Status Codes_: The service responds with appropriate HTTP status codes. A _201 Created_ status is returned for successful session creation, and a _422 Unprocessable Entity_ status is returned in cases of invalid requests.

## Technical Details
1. _Framework_: Ruby on Rails 3.0.6
2. _Database_: SQLite
3. _Testing_: RSpec for unit and controller testing

## Model

### CoachingSession model with the following attributes:

coach_hash_id (String): Unique identifier for the coach.
client_hash_id (String): Unique identifier for the client.
start (DateTime): The start time of the session.
duration (Integer): Duration of the session in minutes.

## Controller

CoachingSessionsController handles the session creation request:

Uses before_action to validate session parameters.
Renders JSON responses with appropriate HTTP status codes based on request validity.

## Validation

Custom validation in the CoachingSession model checks for overlapping session times, ensuring that each coach can only have one session at any given time slot.

## Setup and Configuration

1. **Install Dependencies**: Ensure Ruby and Rails 3.0.6 are installed.
2. **Database Setup**: Run rake db:migrate to set up the SQLite database.
3. **Testing:** Run bundle exec rspec to execute the test suite.

## Usage

To create a new coaching session, send a POST request with the required parameters (coach_hash_id, client_hash_id, start, duration) to the endpoint designated for session creation.
