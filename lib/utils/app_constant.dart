class AppConstant {

  static const String base_url = 'https://midwaystudios.appbeta.net';
  static const String wp_category = base_url + '/wp-json/wp/v2/categories';
  static const String wp_posts = base_url + '/wp-json/wp/v2/posts?_embed&per_page=5&page=';
  static const String wp_search = base_url + '/wp-json/wp/v2/search?_embed&search=';
  static const String wp_post_details = base_url + '/wp-json/wp/v2/posts/';
  static const String wp_post_comment = base_url + '/wp-json/wp/v2/comments?post=';
  static const String wp_register = base_url + '/wp/v2/users?';
  static const String wp_login = base_url + '/';
  static const String wp_category_posts = base_url + '/wp-json/wp/v2/posts?_embed&categories=';
}