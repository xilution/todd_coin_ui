enum TransactionType {
  time,
  treasure;
}

Map<String, TransactionType> transactionTypeStrMap = {
  "TIME": TransactionType.time,
  "TREASURE": TransactionType.treasure,
};

Map<TransactionType, String> transactionTypeMap = {
  TransactionType.time: "TIME",
  TransactionType.treasure: "TREASURE",
};
