# ================================
# Build image
# ================================
FROM swift:5.2-bionic as build
WORKDIR /build

# Install sqlite3
RUN apt-get update -y \
	&& apt-get install -y libsqlite3-dev \
	&& rm -rf /var/lib/apt/lists/*

# First just resolve dependencies.
# This creates a cached layer that can be reused
# as long as your Package.swift/Package.resolved
# files do not change.
COPY ./Package.* ./
RUN swift package resolve

# Copy entire repo into container
COPY . .

# Compile with optimizations
RUN swift build --enable-test-discovery -c release

# ================================
# Run image
# ================================
FROM swift:5.2-bionic-slim

# Create a vapor user and group with /app as its home directory
RUN useradd --user-group --create-home --home-dir /app vapor

WORKDIR /app

# Copy build artifacts
COPY --from=build --chown=vapor:vapor /build/.build/release /app
# Uncomment the next line if you need to load resources from the `Public` directory
#COPY --from=build --chown=vapor:vapor /build/Public /app/Public

# Ensure all further commands run as the vapor user
USER vapor

# Start the Vapor service when the image is run, default to listening on 8080 in production environment 
ENTRYPOINT ["./Run"]
CMD ["serve", "--env", "production", "--hostname", "0.0.0.0", "--port", "8080"]