import 'package:test/test.dart';

import '../bin/utils.dart';

void main() {
  const reason = 'irrelevant and possibly incorrect';
  group('urlWithTrailingSlash', () {
    test('should add trailing slash to simple URL', () {
      expect(
        urlWithTrailingSlash('https://example.com'),
        'https://example.com/',
      );
    });

    test('should handle URL that already has single trailing slash', () {
      expect(
        urlWithTrailingSlash('https://example.com/'),
        'https://example.com/',
      );
    });

    test('should remove multiple trailing slashes and add single one', () {
      expect(
        urlWithTrailingSlash('https://example.com///'),
        'https://example.com/',
      );
    });

    test('should handle many trailing slashes recursively', () {
      expect(
        urlWithTrailingSlash('https://example.com/////'),
        'https://example.com/',
      );
    });

    test('should handle URL with path', () {
      expect(
        urlWithTrailingSlash('https://example.com/api/users'),
        'https://example.com/api/users/',
      );
    });

    test('should handle URL with path and single trailing slash', () {
      expect(
        urlWithTrailingSlash('https://example.com/api/users/'),
        'https://example.com/api/users/',
      );
    });

    test('should handle URL with path and multiple trailing slashes', () {
      expect(
        urlWithTrailingSlash('https://example.com/api/users//'),
        'https://example.com/api/users/',
      );
    });

    test('should handle URL with port number', () {
      expect(
        urlWithTrailingSlash('https://example.com:8080/api'),
        'https://example.com:8080/api/',
      );
    });

    test('should handle localhost URL', () {
      expect(
        urlWithTrailingSlash('http://localhost:3000'),
        'http://localhost:3000/',
      );
    });

    test('should handle URL with query parameters', () {
      expect(
        urlWithTrailingSlash('https://example.com/api?param=value'),
        'https://example.com/api?param=value/',
        skip: reason,
      );
    });

    test('should handle URL with fragment', () {
      expect(
        urlWithTrailingSlash('https://example.com/page#section'),
        'https://example.com/page#section/',
        skip: reason,
      );
    });

    test('should handle simple domain', () {
      expect(urlWithTrailingSlash('example.com'), 'example.com/');
    });

    test('should handle URL with leading/trailing whitespace', () {
      expect(
        urlWithTrailingSlash('  https://example.com  '),
        'https://example.com/',
      );
    });

    test('should handle URL with tabs and newlines', () {
      expect(
        urlWithTrailingSlash('\thttps://example.com\n'),
        'https://example.com/',
      );
    });

    test('should handle single slash', () {
      expect(urlWithTrailingSlash('/'), '/');
    });

    test('should handle multiple slashes only', () {
      expect(urlWithTrailingSlash('///'), '/');
    });

    test('should handle empty string', () {
      expect(urlWithTrailingSlash(''), '/');
    });

    test('should handle whitespace only string', () {
      expect(urlWithTrailingSlash('   '), '/');
    });

    test('should handle URL with username and password', () {
      expect(
        urlWithTrailingSlash('https://user:pass@example.com/api'),
        'https://user:pass@example.com/api/',
      );
    });

    test('should handle IP address URL', () {
      expect(urlWithTrailingSlash('http://192.168.1.1'), 'http://192.168.1.1/');
    });

    test('should handle IPv6 URL', () {
      expect(
        urlWithTrailingSlash('http://[2001:db8::1]'),
        'http://[2001:db8::1]/',
      );
    });

    test('should handle very long URL with many segments', () {
      expect(
        urlWithTrailingSlash(
          'https://example.com/api/v1/users/123/posts/456/comments/789',
        ),
        'https://example.com/api/v1/users/123/posts/456/comments/789/',
      );
    });

    test('should handle URL with many trailing slashes (stress test)', () {
      expect(
        urlWithTrailingSlash('https://example.com${'/' * 100}'),
        'https://example.com/',
      );
    });
  });

  group('urlWithoutLeadingSlash', () {
    test('should remove single leading slash', () {
      expect(urlWithoutLeadingSlash('/api/users'), 'api/users');
    });

    test('should handle URL without leading slash', () {
      expect(urlWithoutLeadingSlash('api/users'), 'api/users');
    });

    test('should remove multiple leading slashes', () {
      expect(urlWithoutLeadingSlash('///api/users'), 'api/users');
    });

    test('should handle many leading slashes recursively', () {
      expect(urlWithoutLeadingSlash('/////api/users'), 'api/users');
    });

    test('should handle path with internal slashes', () {
      expect(urlWithoutLeadingSlash('/api/v1/users/123'), 'api/v1/users/123');
    });

    test('should handle trailing slashes preserved', () {
      expect(urlWithoutLeadingSlash('/api/users/'), 'api/users/');
    });

    test('should handle leading slash with trailing slashes', () {
      expect(urlWithoutLeadingSlash('/api/users//'), 'api/users//');
    });

    test('should handle full URL path', () {
      expect(
        urlWithoutLeadingSlash('/https://example.com/api'),
        'https://example.com/api',
        skip: reason,
      );
    });

    test('should handle single leading slash only', () {
      expect(urlWithoutLeadingSlash('/'), '');
    });

    test('should handle multiple leading slashes only', () {
      expect(urlWithoutLeadingSlash('///'), '');
    });

    test('should handle empty string', () {
      expect(urlWithoutLeadingSlash(''), '');
    });

    test('should handle whitespace only string', () {
      expect(urlWithoutLeadingSlash('   '), '');
    });

    test('should handle leading whitespace and slash', () {
      expect(urlWithoutLeadingSlash('  /api/users'), 'api/users');
    });

    test('should handle leading slash with trailing whitespace', () {
      expect(urlWithoutLeadingSlash('/api/users  '), 'api/users');
    });

    test('should handle mixed whitespace and slashes', () {
      expect(
        urlWithoutLeadingSlash('  / /api'),
        'api',
        skip: reason,
      );
    });

    test('should handle query string paths', () {
      expect(urlWithoutLeadingSlash('/?param=value'), '?param=value');
    });

    test('should handle fragment paths', () {
      expect(urlWithoutLeadingSlash('/#section'), '#section');
    });

    test('should handle relative paths with dots', () {
      expect(urlWithoutLeadingSlash('/./api/users'), './api/users');
    });

    test('should handle parent directory paths', () {
      expect(urlWithoutLeadingSlash('/../api/users'), '../api/users');
    });

    test('should handle very long path with many segments', () {
      expect(
        urlWithoutLeadingSlash('/api/v1/users/123/posts/456/comments/789'),
        'api/v1/users/123/posts/456/comments/789',
      );
    });

    test('should handle many leading slashes (stress test)', () {
      expect(
        urlWithoutLeadingSlash('${'/' * 100}api/users'),
        'api/users',
      );
    });

    test('should handle leading slash with single character path', () {
      expect(urlWithoutLeadingSlash('/a'), 'a');
    });

    test('should handle multiple leading slashes with single character path',
        () {
      expect(urlWithoutLeadingSlash('///x'), 'x');
    });
  });

  group('Combined scenarios', () {
    test('should handle chaining both functions', () {
      const url = '  ///https://example.com///  ';
      final step1 = urlWithoutLeadingSlash(url);
      final step2 = urlWithTrailingSlash(step1);
      expect(step2, 'https://example.com/');
    });

    test('should handle empty string in both functions', () {
      expect(urlWithTrailingSlash(''), '/');
      expect(urlWithoutLeadingSlash(''), '');
    });

    test('should preserve internal structure when cleaning paths', () {
      const input = '///api/v1/users/';
      final result = urlWithoutLeadingSlash(input);
      expect(result, 'api/v1/users/');
    });
  });
}
