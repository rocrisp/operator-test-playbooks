from pkg_resources import parse_version

def filter_sort_versions(value):
    return sorted(value, key=parse_version)

class FilterModule(object):
    filter_sort = {
        'sort_versions': filter_sort_versions,
    }

    def filters(self):
        return self.filter_sort
