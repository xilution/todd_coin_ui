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
import 'package:todd_coin_ui/utilities/app_context.dart';

Future<List<Organization>> loadOrganizations(
    Participant? participant, int? pageNumber, int pageSize) async {
  String? baseUrl = await AppContext.getBaseUrl();
  String? accessToken = await AppContext.getToken();
  if (pageNumber != null && baseUrl != null && accessToken != null) {
    Client client = Client();
    OrganizationBroker organizationBroker =
        OrganizationBroker(client, baseUrl, accessToken);

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

Future<List<Participant>> loadParticipants(
    Organization? organization, int? pageNumber, int pageSize) async {
  String? baseUrl = await AppContext.getBaseUrl();
  String? accessToken = await AppContext.getToken();
  if (pageNumber != null && baseUrl != null && accessToken != null) {
    Client client = Client();
    ParticipantBroker participantBroker =
        ParticipantBroker(client, baseUrl, accessToken);

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

Future<List<ParticipantKey>> loadParticipantKeys(
    Participant participant, int? pageNumber, int pageSize) async {
  String? baseUrl = await AppContext.getBaseUrl();
  String? accessToken = await AppContext.getToken();
  if (pageNumber != null && baseUrl != null && accessToken != null) {
    Client client = Client();
    ParticipantKeyBroker participantKeyBroker =
        ParticipantKeyBroker(client, baseUrl, accessToken);

    List<ParticipantKey> participantKeys = (await participantKeyBroker
            .fetchParticipantKeys(participant, pageNumber, pageSize))
        .rows;

    return participantKeys;
  }
  return [];
}

Future<List<Block>> loadBlocks(int? pageNumber, int pageSize) async {
  String? baseUrl = await AppContext.getBaseUrl();
  String? accessToken = await AppContext.getToken();
  if (pageNumber != null && baseUrl != null && accessToken != null) {
    Client client = Client();
    BlockBroker blockBroker = BlockBroker(client, baseUrl, accessToken);

    List<Block> blocks =
        (await blockBroker.fetchBlocks(pageNumber, pageSize)).rows;

    return blocks;
  }
  return [];
}

Future<List<BlockTransaction>> loadBlockTransactions(
    Block block, int? pageNumber, int pageSize) async {
  String? baseUrl = await AppContext.getBaseUrl();
  String? accessToken = await AppContext.getToken();
  if (pageNumber != null && baseUrl != null && accessToken != null) {
    Client client = Client();
    BlockTransactionBroker blockTransactionBroker =
        BlockTransactionBroker(client, baseUrl, accessToken);

    List<BlockTransaction> blockTransactions = (await blockTransactionBroker
            .fetchBlockTransactions(block, pageNumber, pageSize))
        .rows;

    return blockTransactions;
  }
  return [];
}

Future<List<PendingTransaction>> loadPendingTransactions(
    int? pageNumber, int pageSize) async {
  String? baseUrl = await AppContext.getBaseUrl();
  String? accessToken = await AppContext.getToken();
  if (pageNumber != null && baseUrl != null && accessToken != null) {
    Client client = Client();
    PendingTransactionBroker pendingTransactionBroker =
        PendingTransactionBroker(client, baseUrl, accessToken);

    List<PendingTransaction> pendingTransactions =
        (await pendingTransactionBroker.fetchPendingTransactions(
                pageNumber, pageSize))
            .rows;

    return pendingTransactions;
  }
  return [];
}

Future<List<SignedTransaction>> loadSignedTransactions(
    int? pageNumber, int pageSize) async {
  String? baseUrl = await AppContext.getBaseUrl();
  String? accessToken = await AppContext.getToken();
  if (pageNumber != null && baseUrl != null && accessToken != null) {
    Client client = Client();
    SignedTransactionBroker signedTransactionBroker =
        SignedTransactionBroker(client, baseUrl, accessToken);

    List<SignedTransaction> signedTransactions = (await signedTransactionBroker
            .fetchSignedTransactions(pageNumber, pageSize))
        .rows;

    return signedTransactions;
  }
  return [];
}
