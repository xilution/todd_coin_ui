import 'package:http/http.dart';
import 'package:todd_coin_ui/brokers/block_broker.dart';
import 'package:todd_coin_ui/brokers/block_transaction_broker.dart';
import 'package:todd_coin_ui/brokers/organization_broker.dart';
import 'package:todd_coin_ui/brokers/participant_broker.dart';
import 'package:todd_coin_ui/brokers/participant_key_broker.dart';
import 'package:todd_coin_ui/brokers/pending_transaction_broker.dart';
import 'package:todd_coin_ui/brokers/signed_transaction_broker.dart';
import 'package:todd_coin_ui/models/domain/block.dart';
import 'package:todd_coin_ui/models/domain/block_transaction.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';
import 'package:todd_coin_ui/models/domain/participant.dart';
import 'package:todd_coin_ui/models/domain/participant_key.dart';
import 'package:todd_coin_ui/models/domain/pending_transaction.dart';
import 'package:todd_coin_ui/models/domain/signed_transaction.dart';

Future<List<Organization>> loadOrganizations(String baseUrl,
    Participant? participant, int? pageNumber, int pageSize) async {
  if (pageNumber != null) {
    OrganizationBroker organizationBroker =
        OrganizationBroker(Client(), baseUrl);

    List<Organization> organizations = participant != null
        ? (await organizationBroker.fetchParticipantOrganizations(
                participant, pageNumber, pageSize))
            .rows
        : (await organizationBroker.fetchOrganizations(pageNumber, pageSize))
            .rows;

    return organizations;
  }
  return [];
}

Future<List<Participant>> loadParticipants(String baseUrl,
    Organization? organization, int? pageNumber, int pageSize) async {
  if (pageNumber != null) {
    ParticipantBroker participantBroker = ParticipantBroker(Client(), baseUrl);

    List<Participant> participants = organization != null
        ? (await participantBroker.fetchOrganizationParticipants(
                organization, pageNumber, pageSize))
            .rows
        : (await participantBroker.fetchParticipants(pageNumber, pageSize))
            .rows;

    return participants;
  }
  return [];
}

Future<List<ParticipantKey>> loadParticipantKeys(String baseUrl,
    Participant participant, int? pageNumber, int pageSize) async {
  if (pageNumber != null) {
    ParticipantKeyBroker participantKeyBroker =
        ParticipantKeyBroker(Client(), baseUrl);

    List<ParticipantKey> participantKeys = (await participantKeyBroker
            .fetchParticipantKeys(participant, pageNumber, pageSize))
        .rows;

    return participantKeys;
  }
  return [];
}

Future<List<Block>> loadBlocks(
    String baseUrl, int? pageNumber, int pageSize) async {
  if (pageNumber != null) {
    BlockBroker blockBroker = BlockBroker(Client(), baseUrl);

    List<Block> blocks =
        (await blockBroker.fetchBlocks(pageNumber, pageSize)).rows;

    return blocks;
  }
  return [];
}

Future<List<BlockTransaction>> loadBlockTransactions(
    String baseUrl, Block block, int? pageNumber, int pageSize) async {
  if (pageNumber != null) {
    BlockTransactionBroker blockTransactionBroker =
        BlockTransactionBroker(Client(), baseUrl);

    List<BlockTransaction> blockTransactions = (await blockTransactionBroker
            .fetchBlockTransactions(block, pageNumber, pageSize))
        .rows;

    return blockTransactions;
  }
  return [];
}

Future<List<PendingTransaction>> loadPendingTransactions(
    String baseUrl, int? pageNumber, int pageSize) async {
  if (pageNumber != null) {
    PendingTransactionBroker pendingTransactionBroker =
        PendingTransactionBroker(Client(), baseUrl);

    List<PendingTransaction> pendingTransactions =
        (await pendingTransactionBroker.fetchPendingTransactions(
                pageNumber, pageSize))
            .rows;

    return pendingTransactions;
  }
  return [];
}

Future<List<SignedTransaction>> loadSignedTransactions(
    String baseUrl, int? pageNumber, int pageSize) async {
  if (pageNumber != null) {
    SignedTransactionBroker signedTransactionBroker =
        SignedTransactionBroker(Client(), baseUrl);

    List<SignedTransaction> signedTransactions = (await signedTransactionBroker
            .fetchSignedTransactions(pageNumber, pageSize))
        .rows;

    return signedTransactions;
  }
  return [];
}
