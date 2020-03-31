class Preferences {
    static String _tag;
    static String _annotationType;

    static String get tag => _tag;

    static String get annotationType => _annotationType;

    static void setTag(String tag) {
        _tag = tag;
    }

    static void setAnnotationType(String annotationType) {
        _annotationType = annotationType;
    }
}