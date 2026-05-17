import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class FirestoreService {

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  DocumentSnapshot? lastDocument;

  // =========================
  // FETCH PRODUCTS
  // =========================

  Future<List<ProductModel>> fetchProducts() async {

    Query query = firestore
        .collection("products")

    // Multiple conditions
        .where("category", isEqualTo: "electronics")
        .where("isAvailable", isEqualTo: true)

    // Array filter
        .where("tags", arrayContains: "mobile")

    // Limit results
        .limit(5);

    // Pagination
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    QuerySnapshot snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      lastDocument = snapshot.docs.last;
    }

    return snapshot.docs.map((doc) {

      return ProductModel.fromFirestore(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );

    }).toList();
  }

  // =========================
  // INCREMENT VIEWS
  // =========================

  Future<void> incrementViews(String docId) async {

    await firestore
        .collection("products")
        .doc(docId)
        .update({
      "views": FieldValue.increment(1),
    });
  }

  // =========================
  // BATCH INSERT
  // =========================

  Future<void> batchInsert() async {

    WriteBatch batch = firestore.batch();

    for (int i = 1; i <= 5; i++) {

      DocumentReference docRef =
      firestore.collection("products").doc();

      batch.set(docRef, {
        "name": "Phone $i",
        "category": "electronics",
        "isAvailable": true,
        "views": 0,
        "tags": ["mobile", "android"],
        "createdAt": Timestamp.now(),
      });
    }

    await batch.commit();
  }
}