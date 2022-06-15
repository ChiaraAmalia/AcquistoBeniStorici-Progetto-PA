import { Singleton } from "../singleton";
import { DataTypes, Sequelize } from 'sequelize';

//Ci si connette al database
const sequelize: Sequelize = Singleton.getConnessione();

/*
 * Di seguito vi è l'ORM, che altro non è che il pattern che
 * ci consentirà di interagire con il database.
 * Viene utilizzata, come esplicitamente richiesto, la libreria
 * Sequelize.
 */

//Modella il bene
export const Bene = sequelize.define('bene', {
    id:{
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    nome:{
        type: DataTypes.STRING(20),
        allowNull:false
    },
    tipo:{
        type: DataTypes.ENUM('manoscritto','cartografia storica'),
        allowNull: false
    },
    anno:{
        type: DataTypes.INTEGER,
        allowNull: false
    },
    id_acquisto:{
        type: DataTypes.INTEGER,
        allowNull: true
    }
},
{
    modelName: 'bene',
    timestamps: false,
    freezeTableName: true
});

//modella l'acquisto
export const Acquisto = sequelize.define('acquisto',{
    id:{
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    formato:{
        type: DataTypes.ENUM("jpg","tiff","png"),
        allowNull: false
    },
    tipo_acq:{
        type:DataTypes.ENUM("da scaricare","download originale", "download aggiuntivo"),
        defaultValue: "da scaricare"
    },
    email_compr:{
        type:DataTypes.STRING(35),
        allowNull: false
    }
},
{
    modelName: 'acquisto',
    timestamps: true,
    freezeTableName: true
});

Acquisto.hasMany(Bene);
Bene.belongsTo(Acquisto, {
    foreignKey: {
      name: 'id_acquisto'
    }
  });

//Modella l'utente
export const Utente = sequelize.define('utente',{
    email: {
        type: DataTypes.STRING(35),
        primaryKey: true,
        autoIncrement: true
    },
    username: {
        type: DataTypes.STRING(25),
        allowNull: false
    },
    nome:{
        type: DataTypes.STRING(25),
        allowNull: false
    },
    cognome: {
        type: DataTypes.STRING(25),
        allowNull: false
    },
    ruolo: {
        type: DataTypes.ENUM("user","admin"),
        defaultValue: "user",
    },
    credito: {
        type: DataTypes.INTEGER,
        allowNull: false
    }
},
{
    modelName: 'utente',
    timestamps: false,
    freezeTableName: true
});
Utente.hasMany(Acquisto,{
    foreignKey: {
      name:"email_compr",
      allowNull: false
    }
  });
Acquisto.belongsTo(Utente);
