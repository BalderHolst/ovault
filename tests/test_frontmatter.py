import ovault

def test_construct_frontmatter():
    frontmatter = ovault.Frontmatter()
    frontmatter['title'] = 'Test Note'
    frontmatter['tags'] = ['test', 'example']
    frontmatter['created'] = '2023-10-01'
    frontmatter['updated'] = '2025-08-19'

    expected = ""\
            "title: Test Note\n"\
            "tags: [test, example]\n"\
            "created: 2023-10-01\n"\
            "updated: 2025-08-19\n"

    yaml = frontmatter.yaml(list_style=ovault.ListStyle.Bracketed)

    assert yaml == expected
