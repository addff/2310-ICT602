# 2310-ICT602
Lab Work 5
CRUD
 -
1. Group of 4
2. Using VS Code create the information page detail form.
3. Using Firebase as a Database.
4. Speed Code Video + Music.
5. Create Page for User Information.
6. Create Page for other information (e.g. Product, Transaction, Course or Department)
7. Run on AVD
8. Github page README.md should highlight on VSCode final coding pages + Speedcode.


# GROUP:

MUHAMMAD AIMAN HAZIQ BIN MOHD RAZI (2022879436)

NIK AFIQ AKMAL BIN NIK PAR (2022830644)

SYED FAISAL BIN SYED AB.RAZAK (2022874134)

AHMAD FIKRIE BIN MIRZA (2022873988)

VIdeo Link: https://t.me/c/1268048899/28508?thread=26405

# LAB 5

Full Code VS

READ

```dart
return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            var book = books[index].data() as Map<String, dynamic>;

            return ListTile(
              title: Text(book['title'] ?? 'No Title'),
              subtitle: Text(book['author'] ?? 'No Author'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      // Navigate to the ViewBookScreen with the current book details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewBookScreen(
                            title: book['title'] ?? '',
                            author: book['author'] ?? '',
                            userEmail: userEmail ?? '',
                          ),
                        ),
                      );
                    },
                  ),
```
