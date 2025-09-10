package servlet;

public class Reservation {
    private int resId;
    private String userId;
    private String tripType;
    private String origin;
    private String destination;
    private String departDate;
    private String returnDate;
    private int adultCount;
    private int childCount;
    private int infantCount;

    // Getters and Setters
    public int getResId() { return resId; }
    public void setResId(int resId) { this.resId = resId; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getTripType() { return tripType; }
    public void setTripType(String tripType) { this.tripType = tripType; }

    public String getOrigin() { return origin; }
    public void setOrigin(String origin) { this.origin = origin; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public String getDepartDate() { return departDate; }
    public void setDepartDate(String departDate) { this.departDate = departDate; }

    public String getReturnDate() { return returnDate; }
    public void setReturnDate(String returnDate) { this.returnDate = returnDate; }

    public int getAdultCount() { return adultCount; }
    public void setAdultCount(int adultCount) { this.adultCount = adultCount; }

    public int getChildCount() { return childCount; }
    public void setChildCount(int childCount) { this.childCount = childCount; }

    public int getInfantCount() { return infantCount; }
    public void setInfantCount(int infantCount) { this.infantCount = infantCount; }
}
