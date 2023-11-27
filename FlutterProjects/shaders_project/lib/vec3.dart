import 'dart:math';

class vec3 {
  vec3(this.x, this.y, this.z);

  double x, y, z;

  vec3 rotate(vec3 pitchYawRoll) {
    double sinX = sin(pitchYawRoll.x);
    double cosX = cos(pitchYawRoll.x);
    double sinY = sin(pitchYawRoll.y);
    double cosY = cos(pitchYawRoll.y);
    double sinZ = sin(pitchYawRoll.z);
    double cosZ = cos(pitchYawRoll.z);

    double tempX = x;
    double tempY = y;
    double tempZ = z;

    // Pitch
    double newY = tempY * cosX - tempZ * sinX;
    double newZ = tempY * sinX + tempZ * cosX;

    // Yaw
    double newX = tempX * cosY + newZ * sinY;
    newZ = -tempX * sinY + newZ * cosY;

    // Roll
    newX = newX * cosZ - newY * sinZ;
    newY = newX * sinZ + newY * cosZ;

    return vec3(newX, newY, newZ);
  }

  vec3 negate() {
    return vec3(-x, -y, -z);
  }

  vec3 operator +(vec3 other) {
    return vec3(x + other.x, y + other.y, z + other.z);
  }

  vec3 operator -(vec3 other) {
    return vec3(x - other.x, y - other.y, z - other.z);
  }
}