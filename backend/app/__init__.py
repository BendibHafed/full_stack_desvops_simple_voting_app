import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from dotenv import load_dotenv

db = SQLAlchemy()
migrate = Migrate()


def create_app(config_name=None):
    # load environment variables
    base_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
    load_dotenv(os.path.join(base_dir, ".env"))

    template_folder = os.path.join(base_dir, "frontend", "templates")
    static_folder = os.path.join(base_dir, "frontend", "static")

    app = Flask(__name__, template_folder=template_folder, static_folder=static_folder)

    # decide config
    if not config_name:
        config_name = os.getenv("FLASK_CONFIG", "DevelopmentConfig")
     # map common aliases to actual config classes
    aliases = {
        "dev": "DevelopmentConfig",
        "development": "DevelopmentConfig",
        "prod": "ProductionConfig",
        "production": "ProductionConfig",
        "test": "TestingConfig",
        "testing": "TestingConfig",
    }
    # Normalize input: if user gave an alias, use mapped value.
    # If they already passed a full class name that ends with 'Config', keep it.
    cfg_class = aliases.get(config_name.lower())
    if not cfg_class:
        if config_name.lower().endswith("config"):
            cfg_class = config_name  # assume it's already a proper class name
        else:
            # convert short words (e.g. "staging") to TitleCase + Config
            cfg_class = config_name.capitalize() + "Config"

    # Load the configuration class from backend.app.config
    app.config.from_object(f"backend.app.config.{cfg_class}")

    # init extensions
    db.init_app(app)
    migrate.init_app(app, db)

    # register blueprints
    from backend.app.routes import bp as main_bp
    app.register_blueprint(main_bp)

    return app
