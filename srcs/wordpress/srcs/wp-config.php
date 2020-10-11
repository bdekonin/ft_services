<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'MYSQL_DATABASE' );

/** MySQL database username */
define( 'DB_USER', 'MYSQL_USER' );

/** MySQL database password */
define( 'DB_PASSWORD', 'MYSQL_PASSWORD' );

/** MySQL hostname */
define( 'DB_HOST', 'MYSQL_HOST' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '#>a*xN&5<^jDuBOp7ywJ;PDK`c+FfH+#7v#5l-0p9b=89A[%$|Yg)2uQ-+SPG9T7');
define('SECURE_AUTH_KEY',  '*6_-s>3/*plD:#8+h[S+9[wauj0YC3|[2h.tpIY7$g8FTy+cTP[Si}F-WkuJBf)w');
define('LOGGED_IN_KEY',    'kNS9,xGKf-JLH2zs0i4E|A};} b50`G=!#sA~aQ@$Xz6s6 f2 &6&p#{`z>%MhW-');
define('NONCE_KEY',        '>(`Re@MY0OP[3m9Y[)gV-@p^czmK,k56f:X<JPwNDZrl^4!o5SI/{NZU.9gcO9L!');
define('AUTH_SALT',        ':t1rUYH=g3FzSLeqKggFD G!)/WZ64hjsc]Eab{uE:}-s2$^^$%;|+P}#n0}Wo6?');
define('SECURE_AUTH_SALT', ']1==A^lP+^vnkO<vT,,,bTt)|-i}dfRJL;)P_ZrQ>FDRy+#ju,RtzR{&,FC[viL0');
define('LOGGED_IN_SALT',   ')r$aml:{yOR+YKML9A$U;5~?EGNRfH!Vq}oiF9m#[Uw&s5V{;g_*?JF>usiol*<~');
define('NONCE_SALT',       '+bgDK]gd ZTYz>L._j%igdJ6pmepS2?)~VmJ61J71IWw!%|;5AW+.juxL{U~?Xwe');


/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );