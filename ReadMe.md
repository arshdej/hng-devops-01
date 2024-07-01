# User Management with Docker

This project provides a Dockerized solution for managing user accounts and groups on a Linux system. It includes scripts for creating users and groups based on a configuration file.

## Files

- `Dockerfile`: Docker configuration file to build the image.
- `create_users.sh`: Bash script to create users and groups.
- `users.txt`: Configuration file containing the list of users and their groups.

## Prerequisites

- Docker installed on your system.

## Usage

# User Management Script

This project provides a bash script for managing user accounts and groups on a Linux system. It includes scripts for creating and deleting users and groups based on a configuration file.
It also includes a Dockerized solution.

## Files

- `Dockerfile`: Docker configuration file to build the image.
- `create_users.sh`: Bash script to create users and groups.
- `users.txt`: Configuration file containing the list of users and their groups.

## Usage

### Prerequisites

- Ensure you have the necessary permissions to create users and groups.
- Ensure `openssl` is installed for password generation.

### Preparing the Input File

Create a text file named `users.txt` with the usernames and groups formatted as specified (e.g., `user;groups`).

Example:

```plaintext
light;sudo,dev,www-data
idimma;sudo
mayowa;dev,www-data
```

### Running the User Creation Script

Make the create_users.sh script executable:

```bash
chmod +x create_users.sh
```

### Run the script with the input file as an argument:

```bash
sudo ./create_users.sh users.txt
```

### Building the Docker Image

To build the Docker image, run the following command in the directory containing the Dockerfile and scripts:

```bash
docker build -t user-management .
```

## Running the Container

To run the container and execute the user creation script, use the following command:

```bash
docker run --rm --name user-management-container user-management
```



## Learn More

To explore more about the HNG Internship program, visit:

- [HNG Internship](https://hng.tech/internship)
- [HNG Hire](https://hng.tech/hire)

## License

This project is licensed under the MIT License.
