public with sharing class Die {
    public static Integer roll() {
        return (Math.floor(Math.random() * 6) + 1).intValue();
    }
}
