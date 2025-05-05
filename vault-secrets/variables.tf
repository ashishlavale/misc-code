variable "token" {}

variable "secrets" {
  default = {
    roboshop-dev = {
      description = "RobeShop App Component All secrets"
    }
    roboshop-infra = {
      description = "Roboshop Infra related secrets"
    }
  }
}

variable "values" {
  default = {
    cart = {
      secret = "roboshop-dev"
      value = {
        REDIS_HOST     = "redis-dev.rdevopsb84.online"
        CATALOGUE_HOST = "catalogue-dev.rdevopsb84.online"
        CATALOGUE_PORT = 8080
      }
    }

    catalogue = {
      secret = "roboshop-dev"
      value = {
        MONGO     = "redis-dev.rdevopsb84.online"
        MONGO_URL = "catalogue-dev.rdevopsb84.online"
      }
    }

    user = {
      secret = "roboshop-dev"
      value = {
        MONGO     = "true"
        REDIS_URL = "redis://redis-dev.rdevopsb84.online:6379"
        MONGO_URL = "mongodb://mongodb-dev.rdevopsb84.online:27017/users"
      }
    }

    shipping = {
      secret = "roboshop-dev"
      value = {
        CART_ENDPOINT = "cart-dev.rdevopsb84.online:8080"
        DB_HOST       = "mysql-dev.rdevopsb84.online"
      }
    }

    payment = {
      secret = "roboshop-dev"
      value = {
        CART_HOST = "cart-dev.rdevopsb84.online"
        CART_PORT = "8080"
        USER_HOST = "user-dev.rdevopsb84.online"
        USER_PORT = "8080"
        AMQP_HOST = "rabbitmq-dev.rdevopsb84.online"
        AMQP_USER = "roboshop"
        AMQP_PASS = "roboshop123"
      }
    }

    frontend = {
      secret = "roboshop-dev"
      value = {
        catalogue_url = "http://catalogue-dev.rdevopsb84.online:8080/"
        user_url      = "http://user-dev.rdevopsb84.online:8080/"
        cart_url      = "http://cart-dev.rdevopsb84.online:8080/"
        payment_url   = "http://payment-dev.rdevopsb84.online:8080/"
        shipping_url  = "http://shipping-dev.rdevopsb84.online:8080/"
      }
    }

    rabbitmq = {
      secret = "roboshop-dev"
      value = {
        username = "roboshop"
        password = "roboshop123"
      }
    }

    mysql = {
      secret = "roboshop-dev"
      value = {
        username = "root"
        password = "RoboShop@1"
      }
    }

    ssh = {
      secret = "roboshop-infra"
      value = {
        username = "azuser"
        password = "DevOps@123456"
      }
    }
  }
}

