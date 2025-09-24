# PostgreSQL SSH Debug Container

A lightweight Docker container based on Debian Bullseye that provides SSH access with PostgreSQL client tools for debugging and database operations.

## Features

- **SSH Server**: Accessible on port 2222 with root access
- **PostgreSQL Client**: Pre-installed `postgresql-client` for database operations
- **Lightweight**: Based on Debian Bullseye Slim for minimal footprint
- **Debug-Ready**: Configured for easy access and debugging workflows

## Quick Start

### Build the Container

```bash
docker build -t psql-ssh-debug .
```

### Run the Container

```bash
docker run -d -p 2222:2222 -p 8000:8000 --name psql-debug psql-ssh-debug
```

### Connect via SSH

```bash
ssh root@localhost -p 2222
```

**Default Credentials:**

- Username: `root`
- Password: `Docker!`

## Configuration

### SSH Configuration

The container uses a custom SSH configuration (`sshd_config`) with the following settings:

- **Port**: 2222
- **Root Login**: Enabled
- **Password Authentication**: Enabled
- **X11 Forwarding**: Enabled for GUI applications

### Exposed Ports

- **2222**: SSH access
- **8000**: Additional port for applications/services

## Usage Examples

### Connect to PostgreSQL Database

Once connected via SSH, you can use the PostgreSQL client:

```bash
# Connect to a PostgreSQL database
psql -h your-db-host -p 5432 -U your-username -d your-database

# Or using connection string
psql "postgresql://username:password@host:port/database"
```

### Running with Docker Compose

Create a `docker-compose.yml` file:

```yaml
version: '3.8'
services:
  psql-debug:
    build: .
    ports:
      - "2222:2222"
      - "8000:8000"
    restart: unless-stopped
```

Then run:

```bash
docker-compose up -d
```

## Security Considerations

⚠️ **Warning**: This container is designed for debugging and development purposes. It has:

- Root SSH access enabled
- Simple password authentication
- Should not be used in production environments
- Consider using key-based authentication for increased security

### Using SSH Keys (Recommended)

To use SSH key authentication instead of passwords:

1. Copy your public key to the container:

   ```bash
   docker exec -it psql-debug mkdir -p /root/.ssh
   docker cp ~/.ssh/id_rsa.pub psql-debug:/root/.ssh/authorized_keys
   docker exec -it psql-debug chmod 600 /root/.ssh/authorized_keys
   ```

2. Disable password authentication by modifying `sshd_config`:

   ```text
   PasswordAuthentication no
   ```

## Development

### Building from Source

```bash
git clone <repository-url>
cd psql_ssh_debug_container
docker build -t psql-ssh-debug .
```

### Customization

- Modify `Dockerfile` to add additional tools or packages
- Update `sshd_config` to change SSH settings
- Add environment variables or volumes as needed

## Troubleshooting

### SSH Connection Issues

1. **Check if container is running:**

   ```bash
   docker ps
   ```

2. **Check container logs:**

   ```bash
   docker logs psql-debug
   ```

3. **Verify port mapping:**

   ```bash
   docker port psql-debug
   ```

### PostgreSQL Connection Issues

1. **Test connectivity from within container:**

   ```bash
   docker exec -it psql-debug psql --version
   ```

2. **Check network connectivity:**

   ```bash
   docker exec -it psql-debug ping your-db-host
   ```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Support

If you encounter any issues or have questions, please open an issue on GitHub.
