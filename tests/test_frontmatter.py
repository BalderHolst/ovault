import ovault

def test_construct_frontmatter():
    frontmatter = ovault.Frontmatter()
    frontmatter.set('title', 'Test Note')
    frontmatter.set('tags', ['test', 'example'])
    frontmatter.set('created', '2023-10-01')
    frontmatter.set('updated', '2025-08-19')

    expected = ""\
            "title: Test Note\n"\
            "tags: [test, example]\n"\
            "created: 2023-10-01\n"\
            "updated: 2025-08-19"

    yaml = frontmatter.yaml()

    print(yaml)

    assert yaml == expected
