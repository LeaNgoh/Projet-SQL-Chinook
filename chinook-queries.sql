### I. Requêtes de base

**1. Clients non américains**

```sql
SELECT CustomerId, FirstName, LastName, Country 
FROM Customer 
WHERE Country != 'USA';

```

**2. Clients brésiliens**

```sql
SELECT * FROM Customer 
WHERE Country = 'Brazil';

```

**3. Factures des clients brésiliens**

```sql
SELECT c.FirstName || ' ' || c.LastName AS FullName, i.InvoiceId, i.InvoiceDate, i.BillingCountry
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE c.Country = 'Brazil';

```

**4. Agents de vente**

```sql
SELECT * FROM Employee 
WHERE Title = 'Sales Support Agent';

```

---

### II. Agrégations et relations

**5. Pays uniques dans les factures**

```sql
SELECT DISTINCT BillingCountry 
FROM Invoice;

```

**6. Factures par agent de vente**

```sql
SELECT e.FirstName || ' ' || e.LastName AS SalesAgent, i.*
FROM Employee e
JOIN Customer c ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON c.CustomerId = i.CustomerId
ORDER BY SalesAgent;

```

**7. Détails des factures**

```sql
SELECT i.Total, c.FirstName || ' ' || c.LastName AS CustomerName, c.Country, e.FirstName || ' ' || e.LastName AS SalesAgent
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId
JOIN Employee e ON c.SupportRepId = e.EmployeeId;

```

---

### III. Analyse par année et lignes de facture

**8. Ventes par année (2009 et 2011)**

```sql
SELECT strftime('%Y', InvoiceDate) AS Year, COUNT(InvoiceId) AS InvoiceCount, SUM(Total) AS TotalSales
FROM Invoice
WHERE Year IN ('2009', '2011')
GROUP BY Year;

```

**9. Articles pour la facture 37**

```sql
SELECT COUNT(*) 
FROM InvoiceLine 
WHERE InvoiceId = 37;

```

**10. Articles par facture**

```sql
SELECT InvoiceId, COUNT(InvoiceLineId) AS ItemCount
FROM InvoiceLine
GROUP BY InvoiceId;

```

---

### IV. Détails des morceaux

**11. Nom des morceaux par ligne de facture**

```sql
SELECT il.*, t.Name AS TrackName
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId;

```

**12. Morceaux et artistes par ligne de facture**

```sql
SELECT il.*, t.Name AS TrackName, ar.Name AS ArtistName
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
JOIN Album al ON t.AlbumId = al.AlbumId
JOIN Artist ar ON al.ArtistId = ar.ArtistId;

```

---

### V. Comptages et regroupements

**13. Nombre de factures par pays**

```sql
SELECT BillingCountry, COUNT(*) AS InvoiceCount
FROM Invoice
GROUP BY BillingCountry;

```

**14. Nombre de morceaux par playlist**

```sql
SELECT p.Name, COUNT(pt.TrackId) AS TrackCount
FROM Playlist p
JOIN PlaylistTrack pt ON p.PlaylistId = pt.PlaylistId
GROUP BY p.PlaylistId;

```

**15. Liste des morceaux sans IDs (avec Album, Média, Genre)**

```sql
SELECT t.Name AS Track, a.Title AS Album, m.Name AS MediaType, g.Name AS Genre
FROM Track t
JOIN Album a ON t.AlbumId = a.AlbumId
JOIN MediaType m ON t.MediaTypeId = m.MediaTypeId
JOIN Genre g ON t.GenreId = g.GenreId;

```

---

### VI. Analyse des ventes (Performance)

**16. Factures et articles**

```sql
SELECT i.*, COUNT(il.InvoiceLineId) AS NumberOfItems
FROM Invoice i
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId;

```

**17. Ventes totales par agent**

```sql
SELECT e.FirstName || ' ' || e.LastName AS SalesAgent, ROUND(SUM(i.Total), 2) AS TotalSales
FROM Employee e
JOIN Customer c ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId;

```

**18. Meilleur agent de 2009**

```sql
SELECT e.FirstName || ' ' || e.LastName AS SalesAgent, SUM(i.Total) AS TotalSales
FROM Employee e
JOIN Customer c ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE i.InvoiceDate LIKE '2009%'
GROUP BY e.EmployeeId
ORDER BY TotalSales DESC
LIMIT 1;

```
**18. Meilleur agent de 2010**


```sql
SELECT e.FirstName || ' ' || e.LastName AS SalesAgent, SUM(i.Total) AS TotalSales
FROM Employee e
JOIN Customer c ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE i.InvoiceDate LIKE '2010%'
GROUP BY e.EmployeeId
ORDER BY TotalSales DESC
LIMIT 1;

```
**20. Meilleur agent global**

```sql
SELECT e.FirstName || ' ' || e.LastName AS SalesAgent, SUM(i.Total) AS TotalSales
FROM Employee e
JOIN Customer c ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId
ORDER BY TotalSales DESC
LIMIT 1;

```

---

### VII. Analyse des clients et pays

**21. Clients par agent de vente**

```sql
SELECT e.FirstName || ' ' || e.LastName AS SalesAgent, COUNT(c.CustomerId) AS CustomerCount
FROM Employee e
LEFT JOIN Customer c ON e.EmployeeId = c.SupportRepId
GROUP BY e.EmployeeId;

```

**22. Ventes totales par pays**

```sql
SELECT BillingCountry, SUM(Total) AS TotalSales
FROM Invoice
GROUP BY BillingCountry
ORDER BY TotalSales DESC;
-- Le pays ayant dépensé le plus est les USA.

```

---

### VIII. Analyse des morceaux et artistes

**23. Morceau le plus acheté en 2013**

```sql
SELECT t.Name, COUNT(il.TrackId) AS PurchaseCount
FROM Track t
JOIN InvoiceLine il ON t.TrackId = il.TrackId
JOIN Invoice i ON il.InvoiceId = i.InvoiceId
WHERE i.InvoiceDate LIKE '2013%'
GROUP BY t.TrackId
ORDER BY PurchaseCount DESC
LIMIT 1;

```
-- 24. Top 5 des morceaux les plus achetés
SELECT t.Name, COUNT(il.TrackId) AS PurchaseCount
FROM Track t
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY t.TrackId
ORDER BY PurchaseCount DESC
LIMIT 5;

```
**26. Type de média le plus acheté**
SELECT m.Name, COUNT(il.TrackId) AS PurchaseCount
FROM MediaType m
JOIN Track t ON m.MediaTypeId = t.MediaTypeId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY m.Name
ORDER BY PurchaseCount DESC
LIMIT 1;

```
**25. Top 3 des artistes les plus vendus**

```sql
SELECT ar.Name, COUNT(il.TrackId) AS UnitsSold
FROM Artist ar
JOIN Album al ON ar.ArtistId = al.ArtistId
JOIN Track t ON al.AlbumId = t.AlbumId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY ar.ArtistId
ORDER BY UnitsSold DESC
LIMIT 3;

```

**Pourquoi utiliser des Vues (Views) pour l'automatisation ?**

**Pour l'objectif d'**automatisation**, au lieu de retaper ces requêtes complexes, vous pouvez créer une **Vue**. Par exemple, pour le rapport de performance des agents** :

```sql
CREATE VIEW View_SalesPerformance AS
SELECT e.FirstName || ' ' || e.LastName AS Agent, SUM(i.Total) AS Sales, strftime('%Y', i.InvoiceDate) AS Year
FROM Employee e
JOIN Customer c ON e.EmployeeId = c.SupportRepId
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY Agent, Year;

