-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS fitlife;
USE fitlife;

-- Tabla de Usuarios
CREATE TABLE usuarios (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    fecha_nacimiento DATE,
    genero ENUM('M', 'F', 'Otro'),
    altura DECIMAL(4, 1),
    peso DECIMAL(5, 1),
    nivel_condicion ENUM('Bajo', 'Medio', 'Alto'),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Planes
CREATE TABLE planes (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_plan VARCHAR(50) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(8, 2) NOT NULL,
    nivel ENUM('Basico', 'Intermedio', 'Avanzado') NOT NULL
);

-- Tabla de Suscripciones
CREATE TABLE suscripciones (
    suscripcion_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    plan_id INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado ENUM('Activa', 'Inactiva', 'Cancelada') DEFAULT 'Activa',
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES planes(plan_id) ON DELETE CASCADE
);

-- Tabla de Pagos
CREATE TABLE pagos (
    pago_id INT AUTO_INCREMENT PRIMARY KEY,
    suscripcion_id INT NOT NULL,
    metodo_pago ENUM('Tarjeta Credito', 'Tarjeta Debito', 'PayPal') NOT NULL,
    monto DECIMAL(8, 2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado_pago ENUM('Completado', 'Pendiente', 'Fallido') DEFAULT 'Pendiente',
    FOREIGN KEY (suscripcion_id) REFERENCES suscripciones(suscripcion_id) ON DELETE CASCADE
);

-- Tabla de Entrenamientos
CREATE TABLE entrenamientos (
    entrenamiento_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    fecha_entrenamiento DATE NOT NULL,
    hora_entrenamiento TIME NOT NULL,
    lugar_entrenamiento VARCHAR(100) NOT NULL,
    confirmado ENUM('Si', 'No') DEFAULT 'No',
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id) ON DELETE CASCADE
);

-- Tabla de Contacto
CREATE TABLE contacto (
    contacto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    mensaje TEXT NOT NULL,
    fecha_contacto TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creación de índices para optimización de consultas
CREATE INDEX idx_usuario_id ON suscripciones(usuario_id);
CREATE INDEX idx_plan_id ON suscripciones(plan_id);
CREATE INDEX idx_suscripcion_id ON pagos(suscripcion_id);
CREATE INDEX idx_usuario_entrenamiento ON entrenamientos(usuario_id);

-- Insertar registros de prueba en la tabla de planes
INSERT INTO planes (nombre_plan, descripcion, precio, nivel) VALUES
('Plan Básico', 'Entrenamiento básico para principiantes.', 19.99, 'Basico'),
('Plan Intermedio', 'Entrenamiento intermedio para niveles medios.', 29.99, 'Intermedio'),
('Plan Avanzado', 'Entrenamiento avanzado para niveles altos.', 49.99, 'Avanzado');
